import '../controllers.dart';
import 'package:get/get.dart';

PersegiController? persegiController;
SegitigaController? segitigaController;
LingkaranController? lingkaranController;
LayangController? layangController;
TrapesiumController? trapesiumController;



RxList<Map<String, dynamic>> shapesData(int shapeIndex) {
  // Initialize controllers based on the integer index
  switch (shapeIndex) {
    case 0:
      persegiController = Get.put(PersegiController());
      break;
    case 1:
      segitigaController = Get.put(SegitigaController());
      break;
    case 2:
      lingkaranController = Get.put(LingkaranController());
      break;
    case 3:
      layangController = Get.put(LayangController());
      break;
    case 4:
      trapesiumController = Get.put(TrapesiumController());
      break;
    default:
      throw Exception('Invalid shape index');
  }

  return <Map<String, dynamic>>[
    {
      'name': 'Persegi / Panjang',
      'fields': ['t', 'l'],
      'legend': 'shape_legend/Persegi.svg',
      'formula': 't = tinggi\nl = lebar\nluas = tinggi * lebar',
      'fields_controller': [
        if (shapeIndex == 0) persegiController!.tinggiController,
        if (shapeIndex == 0) persegiController!.lebarController,
      ],
      'calculate': () => persegiController!.calculateArea(),
      'reset': () => persegiController!.reset(),
      'result': () => persegiController!.resultStr.value,
    },
    {
      'name': 'Segitiga',
      'fields': ['t', 'a'],
      'legend': 'shape_legend/Segitiga.svg',
      'formula': 't = tinggi\na = alas\nluas = tinggi * alas / 2',
      'fields_controller': [
        if (shapeIndex == 1) segitigaController!.tinggiController,
        if (shapeIndex == 1) segitigaController!.alasController,
      ],
      'calculate': () => segitigaController!.calculateArea(),
      'reset': () => segitigaController!.reset(),
      'result': () => segitigaController!.resultStr.value,
    },
    {
      'name': 'Lingkaran',
      'fields': ['r'],
      'legend': 'shape_legend/Lingkaran.svg',
      'formula':
          'r = rusuk (diameter / 2)\nd = diameter (rusuk * 2) \nluas = π * r * r',
      'fields_controller': [
        if (shapeIndex == 2) lingkaranController!.jariController
      ],
      'calculate': () => lingkaranController!.calculateArea(),
      'reset': () => lingkaranController!.reset(),
      'result': () => lingkaranController!.resultStr.value,
    },
    {
      'name': 'Layang Layang',
      'fields': ['d1', 'd2'],
      'legend': 'shape_legend/Layang.svg',
      'formula': 'd1 = diagonal 1\nd2 = diagonal 2\nluas = d1 * d2 / 2',
      'fields_controller': [
        if (shapeIndex == 3) layangController!.d1Controller,
        if (shapeIndex == 3) layangController!.d2Controller,
      ],
      'calculate': () => layangController!.calculateArea(),
      'reset': () => layangController!.reset(),
      'result': () => layangController!.resultStr.value,
    },
    {
      'name': 'Trapesium',
      'fields': ['t', 'a', 'b'],
      'legend': 'shape_legend/Trapesium.svg',
      'formula': 't = tinggi\na = sisi a\nb = sisi b\nluas = (a + b) / 2 * t',
      'fields_controller': [
        if (shapeIndex == 4) trapesiumController!.tinggiController,
        if (shapeIndex == 4) trapesiumController!.sisiAController,
        if (shapeIndex == 4) trapesiumController!.sisiBController,
      ],
      'calculate': () => trapesiumController!.calculateArea(),
      'reset': () => trapesiumController!.reset(),
      'result': () => trapesiumController!.resultStr.value,
    },
  ].obs;
}
