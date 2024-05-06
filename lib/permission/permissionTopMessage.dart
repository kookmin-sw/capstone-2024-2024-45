import 'package:flutter/material.dart';

/*
미완_권한 설정 화면_ top message
 */

class PermissionTopMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '시작하기 전에..',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '매듭 창고에서 \n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '“매듭 보내기”',
                  style: TextStyle(
                    color: Color(0xFF7D303D),
                    fontSize: 23,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '를 하기 위해서는, ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '다음 권한들을 ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '허용',
                  style: TextStyle(
                    color: Color(0xFF7D303D),
                    fontSize: 23,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: '해주셔야 해요!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}