import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:suntown/User/test/testAccountData.dart';
import 'package:suntown/main/Exchange/loadingExchange.dart';
import 'package:suntown/main/alert/filter/chooseMinute.dart';
import 'package:suntown/utils/time/changeAmountToTime.dart';
import 'package:suntown/utils/time/changeTimeToAmount.dart';

import '../../User/SendAmount.dart';
import '../../User/scannedUserData/ScannedUser.dart';
import '../../User/scannedUserData/ScannedUserAccountInfo.dart';
import '../../utils/screenSizeUtil.dart';
import '../CustomKeyboard/cusTomKeyboard.dart';
import 'checkExchange.dart';

//30분 단위 ver
//추후 삭제 예정...일단 백업용

class InputTransfor extends StatefulWidget {
  final void Function(String)? onValueSelected; // 콜백 함수 정의
  const InputTransfor({Key? key, this.onValueSelected}) : super(key: key);

  @override
  State<InputTransfor> createState() => _InputTransforState();
}

class _InputTransforState extends State<InputTransfor> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late ScannedUser scannedUser;

  late bool minutesInput;
  late bool hoursInput;
  late String alerttext;
  late int balance;

  late int amount;

  late int hours; //입력 받기 위한..
  late int minutes;


  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();
  ChangeTimeToAmount changeTimeToAmount = ChangeTimeToAmount();

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
    minutesInput = false;
    hoursInput = false;

    scannedUser = ScannedUser(); // UserData 인스턴스 생성
    balance = int.parse(scannedUser.senderBalance);

    alerttext = "";
    amount = 0;

    hours = 0;
    minutes = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    List<int> time = changeAmountToTime.changeAmountToTime(balance);

    int balanceHours = time[0];
    int balanceMinutes = time[1];

    int totalTime = changeTimeToAmount.changeTimeToAmount(balanceHours, balanceMinutes); //분 토탈

    String showTimes = "잔액 : ${balanceHours}시간 ${balanceMinutes}분";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "시간 선택",
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          // 빈 아이콘을 추가하여 빈 공간을 만듭니다.
          IconButton(
            icon: Container(),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   // 여기에 프로필 이미지 설정
                  //   radius: 40, // 이미지 크기 설정
                  //   backgroundImage:
                  //       NetworkImage(scannedUser.profile), // 네트워크 이미지 사용 예시
                  // ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        scannedUser.name,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C533C),
                        ),
                      ),
                      Text(
                        " 님에게",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF4B4A48),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "얼마 만큼의 시간을 보낼까요?",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF4B4A48),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black)), // 아래쪽 테두리를 추가합니다.
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    // 입력 필드의 양쪽 여백을 추가합니다.
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _textController1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none, // 입력 필드의 테두리를 없앱니다.
                      ),
                      style: TextStyle(
                        fontSize: 30, // 원하는 크기로 설정
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (value) {
                        // 입력값이 변경될 때마다 호출되는 콜백 함수입니다.
                        setState(() {
                          if (value.isEmpty) {
                            hours = 0;
                            hoursInput = false;
                          } else {
                            hoursInput = true;
                            hours = int.parse(_textController1.text);

                            print(hours);
                          }
                          // 입력한 시간이 잔액 시간보다 많은지 체크하여 알림 텍스트 업데이트
                          if (hours * 60 + minutes > totalTime) {
                            alerttext = '잔액 시간을 초과했습니다.';
                          } else {
                            alerttext = '';
                          }
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  '시간',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black)), // 아래쪽 테두리를 추가합니다.
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    // 입력 필드의 양쪽 여백을 추가합니다.
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: _textController2,
                      decoration: InputDecoration(
                        border: InputBorder.none, // 입력 필드의 테두리를 없앱니다.
                      ),
                      style: TextStyle(
                        fontSize: 30, // 원하는 크기로 설정
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (value) {
                        // 입력값이 변경될 때마다 호출되는 콜백 함수입니다.
                        setState(() {
                          if (value.isEmpty) {
                            minutes = 0;
                            minutesInput = false;
                          } else {
                            // 입력값을 저장합니다.
                            minutes = int.parse(_textController2.text);
                            minutesInput = true;
                          }
                          // 입력한 시간이 잔액 시간보다 많은지 체크하여 알림 텍스트 업데이트
                          if (hours * 60 + minutes > totalTime) {
                            alerttext = '잔액 시간을 초과했습니다.';
                          } else {
                            alerttext = '';
                          }
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  '분',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    showTimes,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF2C533C),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    alerttext,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF7D303D),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Text(
                        '확인',
                        style: TextStyle(
                          color: Color(0xFFDDE9E2),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: (minutesInput || hoursInput) &&
                              !(minutes == 0 && hours == 0) &&
                              alerttext.length == 0
                          ? () {
                              setState(() {
                                FocusScope.of(context).unfocus();
                              });

                              Future.delayed(Duration(milliseconds: 300), () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CheckExchange(amount: changeTimeToAmount.changeTimeToAmount(hours,minutes)),
                                ));
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(screenWidth * 0.85, screenHeight * 0.09),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBackgroundColor: Colors.grey[400],
                        disabledForegroundColor: Colors.grey,
                        backgroundColor: Color(0xFF2C533C),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
