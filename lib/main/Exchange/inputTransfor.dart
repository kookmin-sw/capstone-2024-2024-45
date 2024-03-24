import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suntown/main/Exchange/connectBlue.dart';

//입력창만들고, 키보드 구현

class InputTransform extends StatefulWidget {
  const InputTransform({super.key});

  @override
  State<InputTransform> createState() => _InputTransformState();
}

class _InputTransformState extends State<InputTransform> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //키보드 숨기기 적용
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body:
            //입력칸
            Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 20,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //text
                      const Align(
                        alignment: Alignment.centerLeft,
                        child :
                        Column(
                          children: [
                            Text(
                              "얼마를 보낼까요?" + "       ",
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "얼마만큼의 햇살을 보낼지",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              "입력해주세요!" + "                   ",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //입력 창
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '액수 입력 칸',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 위젯 넣을 위치
              //button
              const Spacer(),
              SizedBox(
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ConnectBlue()));
                  },
                  child: const Text('송금 하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
