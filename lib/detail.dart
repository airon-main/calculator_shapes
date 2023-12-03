import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'variables/color_pallette.dart';
import 'package:flutter/services.dart';
import 'variables/datadetail.dart';

//* Variables
//? Variables are put outside so it can be used everywhere
RxList<String> resultHistory = <String>[].obs;
int dataIndex = 0;
List<Map<String, dynamic>> shapeData = shapesData(dataIndex);

class Detail extends StatelessWidget {
  const Detail({super.key, required this.dataIndexParam});

  final int dataIndexParam;

  @override
  Widget build(BuildContext context) {
    // Variables if put outside are only called once
    // However it can be initialize multiple time if setted inside a widget that is constantly called.
    dataIndex = dataIndexParam;
    shapeData = shapesData(dataIndex);
    
    return WillPopScope(
      onWillPop: () async {
        // Show a confirmation dialog when the back button is pressed.
        Future<bool> confirm = _showExitConfirmationDialog(context);

        // Return true to allow navigation if the user confirms.
        // Return false to block navigation if the user cancels.
        return confirm;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Luas ' + shapeData[dataIndex]['name'],
            style: const TextStyle(fontFamily: 'Caveat', fontSize: 25),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myLegend(),
              const SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                itemCount: shapeData[dataIndex]['fields'].length,
                itemBuilder: (BuildContext context, index) {
                  return myTextField(index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15);
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  myButton('Calculate', 'calculate'),
                  const SizedBox(width: 12),
                  myButton('Reset', 'reset'),
                  const SizedBox(width: 12),
                  myButton('Reset History', 'reset_history'),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(child: Obx(() => listResult()))
            ],
          ),
        ),
      ),
    );
  }
  // other custom widgets

  myLegend() {
    return Container(
      decoration: BoxDecoration(
        color: colorDark['card'],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorDark['card_darker'],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('assets/' + shapeData[dataIndex]['legend']),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Text(
                shapeData[dataIndex]['formula'],
                style: TextStyle(color: colorDark['light']),
              ),
            ),
          ),
        ],
      ),
    );
  }

  myTextField(index) {
    print('dataIndex: $dataIndex, index: $index');
    print('${shapeData[dataIndex]['fields_controller']}');
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorDark['card']),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            decoration: BoxDecoration(
              color: colorDark['card_darker'],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                shapeData[dataIndex]['fields'][index],
                style: TextStyle(color: colorDark['light'], fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: shapeData[dataIndex]['fields_controller'][index],
              style: TextStyle(
                color: colorDark['light'],
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                filled: false,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 19),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  myButton(String label, String onClick) {
    switch (onClick) {
      case 'calculate':
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorDark['card_darker'],
              foregroundColor: colorDark['light'],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: BorderSide(color: colorDark['card'], width: 1)),
          onPressed: () {
            shapeData[dataIndex]['calculate']();
            resultHistory.add(shapeData[dataIndex]['result']());
          },
          child: Text(label),
        );
      case 'reset':
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorDark['card_darker'],
              foregroundColor: colorDark['light'],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: BorderSide(color: colorDark['card'], width: 1)),
          onPressed: () {
            shapeData[dataIndex]['reset']();
          },
          child: Text(label),
        );
      case 'reset_history':
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorDark['card_darker'],
              foregroundColor: colorDark['light'],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: BorderSide(color: colorDark['card'], width: 1)),
          onPressed: () {
            resultHistory.clear();
          },
          child: Text(label),
        );
    }
  }

  result(BuildContext context, int index) {
    int reversedIndex = resultHistory.length - index - 1;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorDark['card_darker'],
        border: Border.all(color: colorDark['card']),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Text(
              resultHistory[reversedIndex],
              style: TextStyle(color: colorDark['light']),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              color: colorDark['card'],
              width: double.infinity,
              height: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                color: colorDark['light'],
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: resultHistory[reversedIndex]));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Result Copied"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                icon: const Icon(Icons.content_copy, size: 21),
              ),
              IconButton(
                color: colorDark['light'],
                onPressed: () {
                  resultHistory.removeAt(reversedIndex);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Result Deleted"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                icon: const Icon(Icons.delete_forever, size: 25),
              ),
            ],
          ),
        ],
      ),
    );
  }

  listResult() {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return result(context, index);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: resultHistory.length,
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              buttonPadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.all(20),
              content: const Text(
                  'Are you sure you want to exit? \nany get controller will be deleted\nthe result are still there tho :>'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Close the dialog and allow the user to navigate back.
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    // Close the dialog and prevent the user from navigating back.
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        )) ??
        false;
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CustomText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }

  String getText() {
    return text;
  }
}
