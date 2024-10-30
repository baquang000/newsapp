import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/navigation_bar.dart';
import '../controllers/BottomNavigationController.dart';

class HomeViewController extends StatelessWidget {
  const HomeViewController({super.key});


  @override
  Widget build(BuildContext context) {
    BottomNavController controller = Get.put(BottomNavController());
    return Scaffold(
      floatingActionButton: const MyBottomNavigationBar(),
      body: Obx(() => controller.view[controller.index.value]),
    );
  }
}