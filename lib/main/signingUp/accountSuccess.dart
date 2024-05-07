import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/numberScreen.dart';
import 'package:lottie/lottie.dart';
import '../../utils/screenSizeUtil.dart';
import '../mainAccount.dart';

class accountSuccess extends StatefulWidget {
  const accountSuccess({super.key});

  @override
  State<accountSuccess> createState() => _accountSuccessState();
}

class _accountSuccessState extends State<accountSuccess> {
  String username = '';
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false, // 뒤로가기 아이콘 제거
      // ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
              flex: 50,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.025),
                    Text(
                      '창고 만들기가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7D303D),
                        fontSize: screenWidth * 0.1,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '완료',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF7D303D),
                            fontSize: screenWidth * 0.1,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        Text(
                          ' 되었습니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.075,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      // 패딩 설정
                      child: SizedBox(
                        height: screenWidth * 0.85,
                        width: screenHeight * 0.7,
                        child: Lottie.asset("assets/lottie/balloon.json"),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03,),
                    Text(
                      '이제 매듭 창고를 사용해보세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: screenWidth * 0.045,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03,)
                  ]
                )
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainAccount()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  backgroundColor: const Color(0xFF2C533C),
                  foregroundColor: Colors.white,
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
                child: const Text("완료"),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

