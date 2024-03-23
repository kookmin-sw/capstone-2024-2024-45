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
    return GestureDetector( //키보드 숨기기 적용
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 위젯 넣을 위치
              TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '액수 입력 칸',
                  )),
              //button
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConnectBlue()));
                  },
                  child: Text('송금 하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
