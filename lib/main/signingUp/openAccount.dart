import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/nameScreen.dart';

class openAccount extends StatefulWidget {
  const openAccount({super.key});

  @override
  State<openAccount> createState() => _openAccountState();
}

class _openAccountState extends State<openAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 80.0,
            ),
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
                                    '매듭거래를 위한\n창고 개설을 시작해 볼까요?',
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
                                                            '창고 만들기',
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
                        MaterialPageRoute(builder: (context) => nameScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD852),
                    minimumSize: Size.fromHeight(73),

                    foregroundColor: const Color(0xFF4B4A48),

                    textStyle: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("창고 만들기"),
                )
            )

          ],
        ),
      ),
    );
  }
}
