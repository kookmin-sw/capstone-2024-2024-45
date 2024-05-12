import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/numberScreen.dart';
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
                              height: screenHeight * 0.04,
                            ),
                            SizedBox(
                              width: screenWidth * 0.85,
                              height: screenHeight * 0.03, //25
                              child: Text(
                                '창고만들기',
                                style: TextStyle(
                                  color: Color(0xFFD3C2BD),
                                  fontSize: 17,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.85,
                              height : screenHeight * 0.06, // 50
                              child: Text(
                                '이름을 입력해주세요.',
                                style: TextStyle(
                                  color: Color(0xFF4B4A48),
                                  fontSize: 25,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.09,
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
                                  hintStyle: TextStyle(color: Color(0xFFD3C2BD)),
                                  hintText : '한글 이름 입력',
                                ),
                                style :TextStyle(
                                  color: Color(0xFF624A43), //Color(0xFF624A43),
                                  fontSize : 25,
                               ),
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: username.length > 0 ? () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => numberScreen(username:username)),
                  );
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

