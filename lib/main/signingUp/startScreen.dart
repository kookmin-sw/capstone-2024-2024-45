import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';

class startScreen extends StatefulWidget {
  const startScreen({super.key});

  @override
  State<startScreen> createState() => _startScreenState();
}

class _startScreenState extends State<startScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 40),
        child: Column(
          children: [
            Expanded(
                child:SingleChildScrollView(
                   child : Column(
                     children: [
                       Container(
                         width: 343,
                         height: 300,
                         child: Stack(
                           children: [
                             Positioned(
                               left: 0,
                               top: 0,
                               child: SizedBox(
                                 width: 294,
                                 height: 72,
                                 child: Text(
                                   '매듭 거래의 시작.\n매듭 창고를 시작해 볼까요?',
                                   style: TextStyle(
                                     color: Color(0xFF4B4A48),
                                     fontSize: 25,
                                     fontFamily: 'Noto Sans KR',
                                     fontWeight: FontWeight.w700,
                                     height: 0,
                                   ),
                                 ),
                               ),
                             ),
                             Positioned(
                                 left: 0,
                                 top: 152,
                                 child: Container(
                                   width: 343,
                                   height: 148,
                                   child: Column(
                                     mainAxisSize: MainAxisSize.min,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         width: 343,
                                         height: 148,
                                         child: Stack(
                                           children: [
                                             Positioned(
                                               left: 0,
                                               top: 0,
                                               child: Container(
                                                 width: 343,
                                                 height: 44,
                                                 child: Stack(
                                                   children: [
                                                     Positioned(
                                                       left: 73,
                                                       top: 1,
                                                       child: SizedBox(
                                                         width: 270,
                                                         height: 36,
                                                         child: Text(
                                                           '회원가입',
                                                           style: TextStyle(
                                                             color: Color(0xFFFFD852),
                                                             fontSize: 20,
                                                             fontFamily: 'Noto Sans KR',
                                                             fontWeight: FontWeight.w500,
                                                             height: 0,
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                     Positioned(
                                                       left: 0,
                                                       top: 0,
                                                       child: Container(
                                                         width: 44,
                                                         height: 44,
                                                         decoration: ShapeDecoration(
                                                           color: Color(0xFFFFD852),
                                                           shape: OvalBorder(),
                                                         ),
                                                       ),
                                                     ),
                                                     Positioned(
                                                       left: 6,
                                                       top: 7,
                                                       child: SizedBox(
                                                         width: 31,
                                                         height: 24,
                                                         child: Text(
                                                           '1',
                                                           textAlign: TextAlign.center,
                                                           style: TextStyle(
                                                             color: Colors.white,
                                                             fontSize: 25,
                                                             fontFamily: 'Noto Sans KR',
                                                             fontWeight: FontWeight.w500,
                                                             height: 0,
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                             Positioned(
                                               left: 0,
                                               top: 104,
                                               child: Container(
                                                 width: 343,
                                                 height: 44,
                                                 child: Stack(
                                                   children: [
                                                     Positioned(
                                                       left: 73,
                                                       top: 1,
                                                       child: SizedBox(
                                                         width: 270,
                                                         height: 36,
                                                         child: Text(
                                                           '창고 만들기',
                                                           style: TextStyle(
                                                             color: Color(0xFF727272),
                                                             fontSize: 20,
                                                             fontFamily: 'Noto Sans KR',
                                                             fontWeight: FontWeight.w500,
                                                             height: 0,
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                     Positioned(
                                                       left: 0,
                                                       top: 0,
                                                       child: Container(
                                                         width: 44,
                                                         height: 44,
                                                         decoration: ShapeDecoration(
                                                           color: Color(0xFFF9F9F9),
                                                           shape: OvalBorder(
                                                             side: BorderSide(width: 2, color: Color(0xFF727272)),
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                     Positioned(
                                                       left: 6,
                                                       top: 7,
                                                       child: SizedBox(
                                                         width: 31,
                                                         height: 24,
                                                         child: Text(
                                                           '2',
                                                           textAlign: TextAlign.center,
                                                           style: TextStyle(
                                                             color: Color(0xFF727272),
                                                             fontSize: 25,
                                                             fontFamily: 'Noto Sans KR',
                                                             fontWeight: FontWeight.w500,
                                                             height: 0,
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                             Positioned(
                                               left: 22,
                                               top: 49,
                                               child: Transform(
                                                 transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                                                 child: Container(
                                                   width: 51,
                                                   decoration: ShapeDecoration(
                                                     shape: RoundedRectangleBorder(
                                                       side: BorderSide(
                                                         width: 2,
                                                         strokeAlign: BorderSide.strokeAlignCenter,
                                                         color: Color(0xFF727272),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 )
                             )
                           ],
                         ),
                       ),
                     ],
                   )
                )
            ),
            SizedBox(
                width: 343,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signingUP()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFFBD3),
// 버튼의 배경색을 파란색으로 변경
                    foregroundColor: const Color(0xFF4B4A48),
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  child: const Text("매듭 창고 시작하기"),
                )
            )

         ],
        ),
      ),
    );
  }
}
