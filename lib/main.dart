import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/views/home_view_controller.dart';

import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "News App",
      theme: lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: darkTheme,
      home: const HomeViewController(),
    );
  }
}
