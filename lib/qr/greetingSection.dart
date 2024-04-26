import 'package:flutter/material.dart';

  class QrPageTopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "매듭을 받습니다!",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text.rich(
            TextSpan(
              text: '내 ',
              style: TextStyle(
                fontSize: 25,
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
              fontSize: 25,
              color: Color(0xFFFF8D4D),
              fontFamily: 'Noto Sans KR',
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}