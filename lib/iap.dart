import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:device_info_plus/device_info_plus.dart';

class IapService extends GetxService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final RxList<ProductDetails> products = <ProductDetails>[].obs;
  final RxBool pendingPurchase = false.obs;
  final RxBool errorPurchase = false.obs;
  final RxBool premium = false.obs;
  final RxBool isVerifyingPurchase = false.obs;

  final Set<String> _processedReceipts = <String>{};
  final List<String> productIds;

  IapService({required this.productIds});

  @override
  void onInit() {
    super.onInit();
    if (Platform.isIOS) {
      _initIAP();
    } else {
      debugPrint("⚠️ IapService chỉ hỗ trợ iOS (StoreKit2)");
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  Future<void> _initIAP() async {
    _subscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () => debugPrint('---IAP--- stream done'),
      onError: (error) => debugPrint('---IAP--- stream error: $error'),
    );

    await _getProducts();
  }

  Future<void> _getProducts() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      debugPrint("❌ Store not available");
      return;
    }

    final response =
    await _inAppPurchase.queryProductDetails(productIds.toSet());
    products.assignAll(response.productDetails);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint("❌ Products not found: ${response.notFoundIDs}");
    }
  }

  /// Mua sản phẩm
  Future<void> buy(String productId) async {
    final product = products.firstWhere(
          (p) => p.id == productId,
      orElse: () => throw Exception("Product $productId not found"),
    );

    final purchaseParam = PurchaseParam(productDetails: product);

    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Khôi phục purchases
  Future<void> restorePurchases() async {
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      debugPrint("⚠️ Error restoring purchases: $e");
    }
  }

  /// Stream listener
  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchaseDetails in purchaseDetailsList) {
      debugPrint(
          '---IAP--- productID=${purchaseDetails.productID}, status=${purchaseDetails.status}');

      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          pendingPurchase.value = true;
          break;

        case PurchaseStatus.purchased:
          await _handlePurchased(purchaseDetails);
          break;

        case PurchaseStatus.restored:
          await _handleRestoredPurchase(purchaseDetails);
          break;

        case PurchaseStatus.error:
          errorPurchase.value = true;
          pendingPurchase.value = false;
          debugPrint("⚠️ Purchase error: ${purchaseDetails.error}");
          break;

        case PurchaseStatus.canceled:
          pendingPurchase.value = false;
          errorPurchase.value = false;
          break;
      }

      // ✅ StoreKit 2 vẫn cần completePurchase khi pendingCompletePurchase = true
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _handlePurchased(PurchaseDetails purchaseDetails) async {
    final valid = await _verifyPurchase(purchaseDetails);
    if (!valid) {
      debugPrint("❌ Invalid purchase: ${purchaseDetails.productID}");
      return;
    }

    await _deliverProduct(purchaseDetails);
    debugPrint("✅ Purchase successful: ${purchaseDetails.productID}");

    pendingPurchase.value = false;
  }

  Future<void> _handleRestoredPurchase(PurchaseDetails purchaseDetails) async {
    final valid = await _verifyPurchase(purchaseDetails);
    if (valid) {
      await _deliverProduct(purchaseDetails);
      debugPrint("🔄 Purchase restored: ${purchaseDetails.productID}");
      premium.value = true;
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // ✅ Với StoreKit 2 -> dùng serverVerificationData (base64 receipt)
    final receiptData = purchaseDetails.verificationData.serverVerificationData;

    if (_processedReceipts.contains(receiptData) || isVerifyingPurchase.value) {
      return false;
    }

    isVerifyingPurchase.value = true;

    try {
      _processedReceipts.add(receiptData);
      final deviceId = await _getDeviceId();

      // TODO: Gửi receiptData + deviceId tới server để verify với Apple
      debugPrint("🛠 Verify (StoreKit2): receipt=$receiptData, "
          "product=${purchaseDetails.productID}, device=$deviceId");

      return true;
    } catch (e) {
      debugPrint("⚠️ Verify error: $e");
      return false;
    } finally {
      isVerifyingPurchase.value = false;
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    switch (purchaseDetails.productID) {
      case 'consumable_product_id':
        debugPrint("🎁 Deliver consumable: ${purchaseDetails.productID}");
        break;

      case 'subscription_product_id':
        debugPrint("💎 Deliver subscription: ${purchaseDetails.productID}");
        premium.value = true;
        break;

      default:
        debugPrint("📦 Deliver product: ${purchaseDetails.productID}");
    }
  }

  Future<String?> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final ios = await deviceInfo.iosInfo;
    return ios.identifierForVendor;
  }
}
