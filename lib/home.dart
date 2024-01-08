import 'package:calculator_shapes/controllers.dart';
import 'package:calculator_shapes/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calculator_shapes/variables/color_pallette.dart';
import 'package:calculator_shapes/variables/datahome.dart';
import 'package:get/get.dart';

class MyHomePage extends GetView<HomePageController> {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator Bangun Datar",
          style: TextStyle(fontFamily: 'Caveat', fontSize: 25),
        ),
        backgroundColor: colorDark['card'],
        foregroundColor: colorDark['light'],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorDark['background'],
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: shapesData.length,
              itemBuilder: (context, index) {
                return ShapeCardTest(index: index);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShapeCardTest extends StatelessWidget {
  const ShapeCardTest({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Detail(dataIndexParam: index));

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Detail(dataIndex: index)),
        // );
      },
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorDark['card'],
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10), right: Radius.zero),
                color: colorDark['card_darker'],
              ),
              child: SvgPicture.asset('assets/' + shapesData[index]['icon']),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shapesData[index]['calculation_type'],
                      style:
                          TextStyle(fontSize: 10, color: colorDark['disabled']),
                    ),
                    Text(
                      shapesData[index]['name'],
                      style: TextStyle(fontSize: 12, color: colorDark['light']),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 55,
              height: 55,
              child:
                  SvgPicture.asset('assets/icons/solar_arrow-right-broken.svg'),
            )
          ],
        ),
      ),
    );
  }
}
