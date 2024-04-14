// 송금할 금액을 입력하는 곳
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:suntown/main/CustomKeyboard/KeyboardKeys.dart';
import 'package:suntown/main/Exchange/checkExchange.dart';

import '../../User/userData.dart';

class InputTransform extends StatefulWidget {
  const InputTransform({super.key});

  @override
  State<InputTransform> createState() => _InputTransformState();
}

class _InputTransformState extends State<InputTransform> {
  late UserData userData;
  String alerttext = "";
  int balance = 100000; // 잔액 설정, 나중에 api 연동 값으로 바꿀 예정
  String amount = '';
  int parsedAmount = 0;

  //키보드 요소 추가
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

  @override
  void initState() {
    super.initState();
    userData = UserData(); // UserData 인스턴스 생성
  }

  onKeyTap(val) {
    if (val == "0" && amount.length == 0) {
      return;
    }

    if (val == "00" && amount.length == 0) {
      return;
    }
    parsedAmount = int.parse(amount + val);

    if (balance < parsedAmount) {
      setState(() {
        alerttext = '내가 가진 매듭보다 많아요!';
      });
      return;
    }

    setState(() {
      amount = amount + val;
      parsedAmount = int.parse(amount);
    });
  }

  onBackspacePress() {
    if (amount.length == 0) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
      parsedAmount = int.parse(amount.isEmpty ? '0' : amount);
      alerttext = ""; // 백스페이스를 누르면 초과 텍스트를 다시 지움
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
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
    )
        .toList();
  }

  renderAmount() {
    String display = "입력해 주세요";
    String nickname = userData.lastName; //api에서 가져온 닉네임 활용
    String printNickname = "$nickname 님에게"; //닉네임 잘 받아오는지 보기

    TextStyle textStyle = TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    TextStyle nameTextStyle = TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    if (this.amount.length > 0) {
      NumberFormat f = NumberFormat("#,###");
      display = "${f.format(int.parse(amount))}매듭";
      textStyle = textStyle.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  // 여기에 프로필 이미지 설정
                  radius: 50, // 이미지 크기 설정
                  backgroundImage: NetworkImage(userData.avatar), // 네트워크 이미지 사용 예시
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  printNickname,
                  style: nameTextStyle,
                ),
                Text(
                  "얼마 만큼의 매듭을 보낼까요?",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  display,
                  style: textStyle,
                ),
                Text(
                  "잔액 : ${NumberFormat("#,###").format(balance)} 매듭", //api 값 가져오기
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF727272),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  alerttext,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                )
              ]),
        ));
  }

  renderConfirmButton() {
    //버튼
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: amount.length > 0
                ? () {
              // 버튼 활성화 여부에 따라 onPressed 설정
              userData.amount = int.parse(amount);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckExchange()),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.grey[400],
              disabledForegroundColor: Colors.grey,
              foregroundColor: Colors.black,
              backgroundColor: Colors.orange,
            ), // 버튼 비활성화
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "확인",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            renderAmount(),
            ...renderKeyboard(),
            SizedBox(
              height: 20,
            ),
            renderConfirmButton(),
          ]),
        ),
      ),
    );
  }
}
