import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'KeyboardKeys.dart';

class CustomKeyboard extends StatefulWidget {

  final ValueChanged<String> onChanged;

  const CustomKeyboard({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<CustomKeyboard> createState() => _customKeyboardState();
}

class _customKeyboardState extends State<CustomKeyboard> {
  String amount = '';

  List<List<dynamic>> keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [
      '00',
      '0',
      Icon(
        Icons.keyboard_backspace,
        size: 30,
      )
    ],
  ];

  onKeyTap(val) {
    if (val == "0" && amount.length == 0) {
      return;
    }

    if (val == "00" && amount.length == 0) {
      return;
    }
    setState(() {
      amount = amount + val;
      widget.onChanged(amount); // 콜백 함수 호출하여 값 전달
    });
  }

  onBackspacePress() {
    if (amount.length == 0) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
      widget.onChanged(amount); // 콜백 함수 호출하여 값 전달
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) =>
          Center(
            child: Row(
              //키보드에 다음가 같이 center 적용
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: x.map(
                    (y) {
                  return KeyboardKeys(
                      label: y,
                      value: y,
                      onTap: (val) {
                        if (val is Widget) {
                          onBackspacePress();
                        } else {
                          onKeyTap(val);
                        }
                      });
                },
              ).toList(),
            ),
          ),
    )
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: renderKeyboard(),
    );
  }
}