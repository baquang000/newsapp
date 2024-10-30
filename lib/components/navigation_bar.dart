import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/BottomNavigationController.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController controller = Get.put(BottomNavController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 60,
          width: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  controller.index.value = 0;
                },
                child: Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut,
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: controller.index.value == 0
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Icon(
                        Icons.home,
                        size: 25,
                        color: controller.index.value == 0
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.index.value = 1;
                },
                child: Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut,
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: controller.index.value == 1
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Icon(
                        Icons.book,
                        size: 25,
                        color: controller.index.value == 1
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.index.value = 2;
                },
                child: Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut,
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: controller.index.value == 2
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Icon(
                        Icons.settings,
                        size: 25,
                        color: controller.index.value == 2
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
