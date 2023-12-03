import 'package:calculator_shapes/controllers.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}

class DetailBinding extends Bindings {

  final int shapeIndex;

  DetailBinding(this.shapeIndex);

  @override
  void dependencies() {
    switch (shapeIndex) {
      case 0:
        Get.put(PersegiController());
        break;
      case 1:
        Get.put(SegitigaController());
        break;
      case 2:
        Get.put(LingkaranController());
        break;
      case 3:
        Get.put(LayangController());
        break;
      case 4:
        Get.put(TrapesiumController());
        break;
      default:
        throw Exception('Invalid shape index');
    }
  }
}
