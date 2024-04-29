import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/numberScreen.dart';
import 'package:suntown/utils/http_put.dart';
import '../../utils/screenSizeUtil.dart';
class nameScreen extends StatefulWidget {
  const nameScreen({super.key});

  @override
  State<nameScreen> createState() => _nameScreenState();
}

class _nameScreenState extends State<nameScreen> {
  String username = '';
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
                                '이름을 입력해주세요.',
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
                                // 최대 문자 길이
                                maxLength :15,
                                // obscureText: true, 비밀번호 작성할 떄
                                onChanged: (text) {
                                  setState(() {
                                    username = text;
                                    print(username);
                                  });
                                },
                                decoration : InputDecoration(
                                  hintText : '한글 이름 입력',
                                )
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: () async {
                  var data = {
                    'username' : username,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => numberScreen(username:username)),
                  );
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

