import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/utils/http_put.dart';
import '../../utils/screenSizeUtil.dart';
import 'accountSuccess.dart';

class numberScreen extends StatefulWidget {
  final String username;

  const numberScreen({Key? key, required this.username}) :super(key: key);

  @override
  State<numberScreen> createState() => _numberScreenState(username: username);
}

class _numberScreenState extends State<numberScreen> {
  final String username;
  _numberScreenState({required this.username});

  // 전화번호
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
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
                                  color: Color(0xFF727272),
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
                                // obscureText: true, 비밀번호 작성할 떄
                                decoration : InputDecoration(
                                  hintText : '전화번호 입력',
                                ),
                              style :TextStyle(
                                fontSize : screenWidth * 0.06,
                              ),
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => accountSuccess()),
                  );
                  String mobile_number = _phoneNumberController.text;
                  print(mobile_number);
                  var data = {
                    'username' : username,
                    'mobile_number"' : mobile_number,
                    "account_name": username
                  };
                  try {
                    // API 요청을 보냅니다.
                    final value = await httpPut(path: 'api/accounts/register', data:data);
                    if (value == 201) { //put
                      // 성공적으로 응답을 받았을 때 accountSuccess 화면으로 이동합니다.
                      print('201 ok');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => accountSuccess()),
                      );
                    } else {
                      print(value);
                      debugPrint('서버 에러입니다. 다시 시도해주세요');
                    }
                  } catch (e) {
                    debugPrint('API 요청 중 오류가 발생했습니다: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  backgroundColor: const Color(0xFF4B4A48),
                  foregroundColor:Colors.white,
                  minimumSize: Size.fromHeight(73),

                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontFamily: 'Noto Sans KR',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 0,

                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("다음"),
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