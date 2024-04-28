import 'package:flutter/material.dart';

import '../utils/screenSizeUtil.dart';

class QrPageTopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "매듭을 받습니다!",
            style: TextStyle(fontSize: screenWidth * 0.075),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Text.rich(
            TextSpan(
              text: '내 ',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                color: Color(0xFFFF8D4D),
                fontFamily: 'Noto Sans KR',
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '"매듭코드"',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '를',
                ),
              ],
            ),
          ),
          Text(
            "매듭을 받을 이웃에게 보여주세요!",
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              color: Color(0xFFFF8D4D),
              fontFamily: 'Noto Sans KR',
            ),
          ),
          SizedBox(
            height: screenHeight * 0.012,
          ),
        ],
      ),
    );
  }
}