import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PersegiController extends GetxController {
  final resultStr = "Please fill the fields".obs;
  final tinggiController = TextEditingController();
  final lebarController = TextEditingController();

  calculateArea() {
    double? tinggi = double.tryParse(tinggiController.text);
    double? lebar = double.tryParse(lebarController.text);

    if (tinggi == null || lebar == null) {
      resultStr.value = "Please fill the fields";
    } else {
      double result = tinggi * lebar;
      resultStr.value = "Result: $result";
    }
  }

  reset() {
    tinggiController.text = "";
    lebarController.text = "";
    resultStr.value = "Please fill the fields";
  }
}

class SegitigaController extends GetxController {
  final resultStr = "Please fill the fields".obs;
  final tinggiController = TextEditingController();
  final alasController = TextEditingController();

  calculateArea() {
    double? tinggi = double.tryParse(tinggiController.text);
    double? alas = double.tryParse(alasController.text);

    if (tinggi == null || alas == null) {
      resultStr.value = "Please fill the fields";
    } else {
      double result = tinggi * alas / 2;
      resultStr.value = "Result: $result";
    }
  }

  reset() {
    tinggiController.text = "";
    alasController.text = "";
    resultStr.value = "Please fill the fields";
  }
}

class LingkaranController extends GetxController {
  final resultStr = "Please fill the fields".obs;
  final jariController = TextEditingController();

  calculateArea() {
    double? jari = double.tryParse(jariController.text);

    if (jari == null) {
      resultStr.value = "";
    } else {
      double result = pi * pow(jari, 2);
      resultStr.value = "Result: $result";
    }
  }

  reset() {
    jariController.text = "";
    resultStr.value = "";
  }
}

class LayangController extends GetxController {
  final resultStr = "Please fill the fields".obs;
  final d1Controller = TextEditingController();
  final d2Controller = TextEditingController();

  calculateArea() {
    double? d1 = double.tryParse(d1Controller.text);
    double? d2 = double.tryParse(d2Controller.text);

    if (d1 == null || d2 == null) {
      resultStr.value = "Please fill the fields";
    } else {
      double result = d1 * d2 / 2;
      resultStr.value = "Result: $result";
    }
  }

  reset() {
    d1Controller.text = "";
    d2Controller.text = "";
    resultStr.value = "Please fill the fields";
  }
}

class TrapesiumController extends GetxController {
  final resultStr = "Please fill the fields".obs;
  final tinggiController = TextEditingController();
  final sisiAController = TextEditingController();
  final sisiBController = TextEditingController();

  calculateArea() {
    double? tinggi = double.tryParse(tinggiController.text);
    double? sisiA = double.tryParse(sisiAController.text);
    double? sisiB = double.tryParse(sisiAController.text);

    if (tinggi == null || sisiA == null || sisiB == null) {
      resultStr.value = "Please fill the fields";
    } else {
      double result = (sisiA + sisiB) / 2 * tinggi;
      resultStr.value = "Result: $result";
    }
  }

  reset() {
    tinggiController.text = "";
    sisiAController.text = "";
    sisiBController.text = "";
    resultStr.value = "Please fill the fields";
  }
}

class HomePageController extends GetxController {
  RxString testString = "This is a test String".obs;
}
