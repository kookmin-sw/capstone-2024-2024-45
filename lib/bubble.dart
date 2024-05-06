import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:suntown/utils/screenSizeUtil.dart';

class TopSideBubble extends StatelessWidget {
  const TopSideBubble({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.09,
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 20,
        bottom: 10,
      ),
      decoration: ShapeDecoration(
        color: Color(0xFFEFE7DA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          side: BorderSide(
            color: Color(0xFFD0BAAD), // 겉 선의 색상
            width: 1, // 겉 선의 두께
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
              child: Image(
                image: AssetImage('assets/images/knot.png'),
              ),
            ),
          ),
          Spacer(),
          //말풍선 텍스트
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.bottomRight,
              // 텍스트를 말풍선 아래에 위치시킴
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TypewriterAnimatedTextKit(
                    text: ["오늘도 나눔에 앞장서는\n아름다운 당신을 응원합니다!"],
                    textStyle: TextStyle(
                      color: Color(0xff624A43),
                      fontSize: screenWidth * 0.037,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                    speed: Duration(milliseconds: 60),
                    totalRepeatCount: 1,
                    // 애니메이션 반복 횟수
                    isRepeatingAnimation: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
