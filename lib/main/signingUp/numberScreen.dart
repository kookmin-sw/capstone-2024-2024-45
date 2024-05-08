import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suntown/main/manage/accountInfoManage.dart';

import '../../utils/screenSizeUtil.dart';
import 'accountSuccess.dart';
import '../manage/userInfoManage.dart';


class numberScreen extends StatefulWidget {
  final String username;
  const numberScreen({Key? key, required this.username}) :super(key: key);

  @override
  State<numberScreen> createState() => _numberScreenState(username: username);
}

class _numberScreenState extends State<numberScreen> {
  final String username;
  _numberScreenState({required this.username});

  late TextEditingController _phoneNumberController;
  late String mobile_number;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    mobile_number = _phoneNumberController.text;
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false, // 뒤로가기 아이콘 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 왼쪽에 추가할 아이콘
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                      child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:  screenHeight * 0.04,
                            ),
                            SizedBox(
                              width: screenWidth * 0.85, // 334
                              height: screenHeight * 0.03, // 25
                              child: Text(
                                '창고만들기',
                                style: TextStyle(
                                  color: Color(0xFFD3C2BD),
                                  fontSize: screenWidth * 0.037,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.85,
                              height :  screenHeight * 0.06, // 50
                              child: Text(
                                '전화번호를 입력해주세요.',
                                style: TextStyle(
                                  color: Color(0xFF4B4A48),
                                  fontSize: screenWidth * 0.06,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height:  screenHeight * 0.09, //75
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly, //숫자만!
                                  NumberFormatter(), // 자동하이픈
                                  LengthLimitingTextInputFormatter(13)
                                ],
                                onChanged: (text) {
                                  setState(() {
                                    mobile_number = text;
                                  });
                                },
                                // obscureText: true, 비밀번호 작성할 떄
                                decoration : InputDecoration(
                                  hintStyle: TextStyle(color: Color(0xFFD3C2BD)),
                                  hintText : '전화번호 입력',
                                ),
                              style :TextStyle(
                                color: Color(0xFF624A43),
                                fontSize : screenWidth * 0.06,
                              ),
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: mobile_number.length ==  13 ? () async {
                    bool userResuccess = await UserInfoMange().fetchUserData(name:username, mobile_number:mobile_number);
                    bool accoutnResuccess =  await AccountInfoMange().fetchAccountData( username:  username, mobile_number:mobile_number, password: "");
;                    if (userResuccess){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => accountSuccess()),
                      );
                    }
                    else{
                      // 알림화면 띄우는걸로 변경 예정
                      print("오류");
                    }
                    print(mobile_number);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => passwordScreen(username : username,mobile_number:mobile_number )),
//                   );
                }
                : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  backgroundColor: const Color(0xFFD3C2BD),
                  foregroundColor:Colors.white,
                  minimumSize: Size.fromHeight(73),

                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.055,

                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                    "다음",
                    style : TextStyle(
                      color: Color(0xFF624A43),
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    )
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}