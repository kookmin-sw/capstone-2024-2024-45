import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suntown/main/Exchange/loadingExchange.dart';
import 'package:suntown/main/alert/filter/chooseMinute.dart';

import '../../User/SendAmount.dart';
import '../../User/scannedUserData/ScannedUser.dart';
import '../../User/scannedUserData/ScannedUserAccountInfo.dart';
import '../../utils/screenSizeUtil.dart';

//30분 단위 ver
//추후 삭제 예정...일단 백업용

class minutesInputTransfor extends StatefulWidget {
  final void Function(String)? onValueSelected; // 콜백 함수 정의
  const minutesInputTransfor({Key? key, this.onValueSelected}) : super(key: key);

  @override
  State<minutesInputTransfor> createState() => _InputTransforState();
}

class _InputTransforState extends State<minutesInputTransfor> {
  late TextEditingController _textController;
  late ScannedUser scannedUser;
  late SendApi sendData;
  late ScannedUserAccountInfo
      scannedUserAccountInfo; //나중에 이것도 받아오는 fetch 작성해야 함

  late bool minutesInput;
  late String alerttext;
  late int balance;

  late int hours;
  late int minutes;

  @override
  void initState() {
    super.initState();
    minutesInput = false;
    sendData = SendApi();
    scannedUser = ScannedUser(); // UserData 인스턴스 생성
    balance = int.parse(scannedUser.senderBalance);
    _textController = TextEditingController();

    alerttext = "";
    hours = 0;
    minutes = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    int showHours = 0;
    int showMinutes = 0;

    showHours = (balance / 60).toInt();
    showMinutes = (balance % 60).toInt();

    String showTimes = "잔액 : ${showHours}시간 ${showMinutes}분";

    FocusNode inputNode = FocusNode();

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
            SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          // 여기에 프로필 이미지 설정
                          radius: 30, // 이미지 크기 설정
                          backgroundImage: NetworkImage(
                              scannedUser.profile), // 네트워크 이미지 사용 예시
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
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
                              "님에게",
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
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '00',
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
                                } else {
                                  hours = int.parse(value);
                                }
                                // 입력한 시간이 잔액 시간보다 많은지 체크하여 알림 텍스트 업데이트
                                if (hours * 60 + minutes > balance) {
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
                          child: TextField(
                            focusNode: inputNode,
                            textAlign: TextAlign.center,
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: '00',
                              border: InputBorder.none, // 입력 필드의 테두리를 없앱니다.
                            ),
                            onTap: () {
                              FocusScope.of(context).requestFocus(
                                  inputNode); // TextField를 탭할 때 포커스를 얻습니다.
                              chooseMinutes.showExpiredCodeDialog(
                                  context, inputNode, onValueSelected: (value) {
                                // 콜백 함수를 통해 선택한 값을 받아와서 textField를 업데이트
                                setState(() {
                                  _textController.text = value;
                                  minutes = int.parse(value); // 입력값을 저장합니다.

                                  if (value.length > 0) {
                                    minutesInput = true;
                                  } else {
                                    minutesInput = false;
                                  }
                                  // 입력한 시간이 잔액 시간보다 많은지 체크하여 알림 텍스트 업데이트
                                  if (hours * 60 + minutes > balance) {
                                    alerttext = '잔액 시간을 초과했습니다.';
                                  } else {
                                    alerttext = '';
                                  }
                                });
                              }); // 사용자 정의 다이얼로그를 표시합니다.
                            },
                            style: TextStyle(
                              fontSize: 30, // 원하는 크기로 설정
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w400,
                            ),
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
                            showTimes,
                          ),
                          Text(
                            alerttext,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF2C533C),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                '송금 취소 요청하기',
                style: TextStyle(
                  color: Color(0xFF624A43),
                  fontSize: 20,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: minutesInput &&
                      !(hours == 0 && minutes == 0) &&
                      alerttext.length != 0
                  ? () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoadingExchange()));
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.85, screenHeight * 0.09),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFFD3C2BD),
                disabledBackgroundColor: Colors.grey[400],
                disabledForegroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
