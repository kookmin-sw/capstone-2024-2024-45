import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suntown/main/signingUp/register/accountInfoRegister.dart';

import '../../utils/screenSizeUtil.dart';
import 'accountSuccess.dart';
import 'register/userInfoRegister.dart';

class passwordScreen extends StatefulWidget {
  final String username;
  final String mobile_number ;
  const passwordScreen({Key? key, required this.username, required this.mobile_number}) :super(key: key);

  @override
  State<passwordScreen> createState() => _passwordScreenState(username: username,  mobile_number : mobile_number);
}

class _passwordScreenState extends State<passwordScreen> {
  final String username;
  final String mobile_number;
  _passwordScreenState({required this.username, required this.mobile_number});

  late TextEditingController _passwordController;
  late String password;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    password = _passwordController.text;
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
                              height :  screenHeight * 0.05, // 50
                              child: Text(
                                '비밀번호 6자리를 입력해주세요.',
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
                              width: screenWidth * 0.85,
                              height :  screenHeight * 0.06, // 50
                              child: Text(
                                '시간 보내기와 앱 시작할 때 사용합니다.',
                                style: TextStyle(
                                  color: Color(0xFF624A43),
                                  fontSize: screenWidth * 0.037,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height:  screenHeight * 0.05, //75
                            ),
                            TextField(
                              obscureText: true,
                              textAlign: TextAlign.center,
                              controller: _passwordController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly, //숫자만!
                                LengthLimitingTextInputFormatter(6)
                              ],
                              onChanged: (text) {
                                setState(() {
                                  password = text;
                                });
                              },
                              decoration : InputDecoration(
                                // border: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Color(0xFFD3C2BD)),
                                hintText : '비밀번호 입력',
                              ),
                              style :TextStyle(
                                color: Color(0xFF624A43),
                                fontSize : screenWidth * 0.075,
                              ),
                            ),

                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: password.length ==  6 ? () async {
                  // bool userResuccess = await UserInfoRegister().fetchUserData(name:username, mobile_number:mobile_number);
                  // bool accoutnResuccess =  await AccountInfoRegister().fetchAccountData( username:  username, mobile_number:mobile_number, password: "");
                  // if (userResuccess && accoutnResuccess){
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => accountSuccess()),
                  //   );
                  // }
                  // else{
                  //   // 알림화면 띄우는걸로 변경 예정
                  //   print("오류");
                  // }
                  // print(pasward);
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