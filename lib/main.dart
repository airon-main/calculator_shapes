import 'package:calculator_shapes/bindings.dart';
import 'package:calculator_shapes/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'variables/color_pallette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorDark['card']),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => const MyHomePage(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
