import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../User/refundUserData/RefundUser.dart';
import '../../utils/screenSizeUtil.dart';
import '../../utils/time/changeAmountToTime.dart';
import '../../utils/time/changeTimeToAmount.dart';
import '../alert/filter/chooseMinute.dart';
import 'loadingRefund.dart';

//분 단위 고정 없음. 현재는 입력 시 여기 연결됌!!!

typedef void TextFieldCallback(String value);

class RefundInput extends StatefulWidget {
  final void Function(String)? onValueSelected; // 콜백 함수 정의
  const RefundInput({Key? key, this.onValueSelected}) : super(key: key);

  @override
  State<RefundInput> createState() => _RefundInputState();
}

class _RefundInputState extends State<RefundInput> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late RefundUser refundUser;
  late bool minutesInput;
  late bool hoursInput;

  late int hours; //입력 받기 위한..
  late int minutes;

  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();
  ChangeTimeToAmount changeTimeToAmount = ChangeTimeToAmount();

  @override
  void initState() {
    super.initState();
    minutesInput = false;
    hoursInput = false;

    refundUser = RefundUser();

    _textController1 = TextEditingController();
    _textController2 = TextEditingController();

    hours = 0;
    minutes = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "송금 취소를 원하시나요?",
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
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "다시 보낼 시간을 입력해주세요!",
                      style: TextStyle(
                        color: Color(0xFF7D303D),
                        fontSize: 23,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "얼마를 보내려 했나요?",
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
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
                        controller: _textController1,
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
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                '송금 취소 요청하기',
                style: TextStyle(
                  color: Color(0xFFDDE9E2),
                  fontSize: 20,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                ),
              ),onPressed: (minutesInput || hoursInput) &&
                !(minutes == 0 && hours == 0)
                ? () {
              setState(() {
                refundUser.expectedAmount = changeTimeToAmount.changeTimeToAmount(hours,minutes).toString();
                FocusScope.of(context).unfocus();
              });

              Future.delayed(Duration(milliseconds: 300), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoadingRefund()));
              });
            }
                : null,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.85, screenHeight * 0.09),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFF2C533C),
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
