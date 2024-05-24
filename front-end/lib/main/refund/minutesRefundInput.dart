
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../User/refundUserData/RefundUser.dart';
import '../../utils/screenSizeUtil.dart';
import '../alert/filter/chooseMinute.dart';
import 'loadingRefund.dart';

//30분 단위...삭제 예정

typedef void TextFieldCallback(String value);

class minutesRefundInput extends StatefulWidget {

  final void Function(String)? onValueSelected; // 콜백 함수 정의
  const minutesRefundInput({Key? key, this.onValueSelected}) : super(key: key);

  @override
  State<minutesRefundInput> createState() => _RefundInputState();
}

class _RefundInputState extends State<minutesRefundInput> {
  late TextEditingController _textController;
  late RefundUser refundUser;
  late bool minutesInput;

  @override
  void initState() {
    super.initState();
    minutesInput = false;
    refundUser = RefundUser();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    FocusNode inputNode = FocusNode();

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
                    Text("다시 보낼 시간을 입력해주세요!",
                      style: TextStyle(
                        color: Color(0xFF7D303D),
                        fontSize: 23,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("얼마를 보내려 했나요?",
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
                            // if (value.isEmpty) {
                            //   refundUser.hours = 0;
                            // } else {
                            //   refundUser.hours = int.parse(value);
                            // }
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
                          FocusScope.of(context).requestFocus(inputNode); // TextField를 탭할 때 포커스를 얻습니다.
                          chooseMinutes.showExpiredCodeDialog(context, inputNode, onValueSelected: (value) {
                            // 콜백 함수를 통해 선택한 값을 받아와서 textField를 업데이트
                            setState(() {
                              _textController.text = value;
                              // refundUser.minutes = int.parse(value); // 입력값을 저장합니다.
                              // print("minutes길이 : ${value.length}");
                              // print(refundUser.minutes);
                              if(value.length >0){
                                minutesInput = true;
                              }else{
                                minutesInput = false;
                              }
                            });
                          });// 사용자 정의 다이얼로그를 표시합니다.
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
              onPressed:
              // minutesInput && !(refundUser.hours == 0 && refundUser.minutes == 0) //둘다 들어와야 넘어갈 수 있음
              //     ?
                () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoadingRefund()));
                });
              }
              // : null
              ,
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
