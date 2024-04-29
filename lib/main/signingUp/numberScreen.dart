import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/utils/http_put.dart';
import '../../utils/screenSizeUtil.dart';
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
                              height: 75,
                            ),
                            SizedBox(
                              width: 119,
                              height: 25,
                              child: Text(
                                '창고만들기',
                                style: TextStyle(
                                  color: Color(0xFF4B4A48),
                                  fontSize: screenWidth * 0.037,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 343,
                              height : 51,
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
                              height: 77,
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // 숫자만 입력하도록 제한
                                // 최대 문자 길이
                                maxLength :11,
                                // obscureText: true, 비밀번호 작성할 떄
                                decoration : InputDecoration(
                                  hintText : '전화번호 입력',
                                )
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: () async {
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
                      // 성공적으로 응답을 받았을 때 FinishExchange 화면으로 이동합니다.
                      print('201 ok');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainAccount()),
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

