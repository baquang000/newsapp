import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

/// Service quản lý In-App Purchases (IAP) với GetX
class InAppPurchaseService extends GetxService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  /// State
  final Rx<ProductDetails?> selectedProduct = Rx<ProductDetails?>(null);
  final RxList<ProductDetails> availableProducts = <ProductDetails>[].obs;
  final RxBool isLoading = false.obs;

  /// Các gói cần đăng ký
  final Set<String> productIds = {
    'auto_renew_monthly_plan',
    'auto_renew_annual_plan',
  };

  Completer<bool>? _purchaseCompleter;

  /// Dùng để lưu trạng thái local / server
  final String _lastPurchaseDateKey = "last_purchase_date";
  final String _purchaseDurationKey = "purchase_duration";

  @override
  void onInit() {
    super.onInit();
    _listenToPurchaseUpdates();
  }

  @override
  void onClose() {
    _purchaseSubscription?.cancel();
    super.onClose();
  }

  /// Khởi tạo và load sản phẩm
  Future<void> initialize() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) throw Exception("IAP không khả dụng trên thiết bị này");

    final response = await _inAppPurchase.queryProductDetails(productIds);
    if (response.notFoundIDs.isNotEmpty) {
      log("❌ Không tìm thấy: ${response.notFoundIDs}");
    }

    availableProducts.assignAll(response.productDetails);

    // iOS thường yêu cầu restore thủ công, nhưng bạn có thể bật auto restore
    if (availableProducts.isEmpty) {
      await restorePurchases();
    }
  }

  /// Chọn sản phẩm
  void setSelectedProduct(ProductDetails? productDetails) {
    selectedProduct.value = productDetails;
  }

  /// Mua sản phẩm
  Future<(bool, String)> purchase(ProductDetails product) async {
    isLoading.value = true;
    try {
      final param = PurchaseParam(
        productDetails: product,
        applicationUserName: "ap.screenshot.pro", // có thể thay UID thực tế
      );

      await _inAppPurchase.buyNonConsumable(purchaseParam: param);

      _purchaseCompleter = Completer<bool>();

      final success = await _purchaseCompleter!.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          _purchaseCompleter?.complete(false);
          return false;
        },
      );

      return success
          ? (true, "✅ Mua thành công")
          : (false, "⚠️ Mua thất bại hoặc bị hủy");
    } on PlatformException catch (e) {
      final msg = e.code == 'storekit_duplicate_product_object'
          ? "Có giao dịch đang chờ xử lý. Hãy thử lại sau."
          : "Lỗi khi mua: ${e.message}";
      log("⚠️ $msg");
      return (false, msg);
    } finally {
      isLoading.value = false;
    }
  }

  /// Khôi phục purchase (iOS)
  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases(
      applicationUserName: "ap.screenshot.pro",
    );
  }

  /// Lắng nghe purchase stream
  void _listenToPurchaseUpdates() {
    _purchaseSubscription = _inAppPurchase.purchaseStream.listen(
          (purchases) async {
        for (final p in purchases) {
          switch (p.status) {
            case PurchaseStatus.purchased:
            case PurchaseStatus.restored:
              await _handlePurchase(p);
              break;
            case PurchaseStatus.canceled:
              await _handleCancellation(p);
              break;
            case PurchaseStatus.error:
              _handleError(p.error);
              break;
            default:
              log("ℹ️ Status khác: ${p.status}");
          }
        }
      },
      onError: (e) => log("❌ Purchase stream error: $e"),
    );
  }

  /// Xử lý purchase thành công
  Future<void> _handlePurchase(PurchaseDetails details) async {
    if (details.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(details);
    }

    try {
      final now = DateTime.now();
      const uid = "user123"; // TODO: truyền từ auth

      if (details.productID == 'auto_renew_monthly_plan') {
        await _savePurchase(details.productID, uid, now, 30);
      } else if (details.productID == 'auto_renew_annual_plan') {
        await _savePurchase(details.productID, uid, now, 365);
      }

      _purchaseCompleter?.complete(true);
    } catch (e) {
      log("❌ Xử lý purchase thất bại: $e");
      _purchaseCompleter?.complete(false);
    } finally {
      isLoading.value = false;
    }
  }

  /// Lưu purchase (SharedPreferences/Firestore tuỳ bạn)
  Future<void> _savePurchase(
      String productID,
      String uid,
      DateTime date,
      int days,
      ) async {
    final expiry = date.add(Duration(days: days));
    final planType =
    productID == 'auto_renew_monthly_plan' ? "monthly" : "annual";

    log("💾 Lưu purchase: $productID ($planType), hết hạn: $expiry");

    // TODO: SharedPreferences + Firestore
    // Ví dụ:
    // await _sharedPreferences.setInt(_lastPurchaseDateKey, date.millisecondsSinceEpoch);
    // await _sharedPreferences.setInt(_purchaseDurationKey, days);
    // await _firestore.collection('users').doc(uid).set({...}, SetOptions(merge: true));
  }

  /// Huỷ purchase
  Future<void> _handleCancellation(PurchaseDetails details) async {
    log("⚠️ Purchase bị huỷ: ${details.productID}");
    _purchaseCompleter?.complete(false);
    isLoading.value = false;

    // TODO: cập nhật Firestore nếu cần
  }

  /// Lỗi purchase
  void _handleError(IAPError? error) {
    log("❌ Purchase error: ${error?.message}");
    _purchaseCompleter?.complete(false);
    isLoading.value = false;
  }
}
