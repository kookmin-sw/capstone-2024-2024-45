// 블루투스 연결 오류 alret

import 'package:flutter/material.dart';

class missConnectAlert extends StatefulWidget {
  const missConnectAlert({super.key});

  @override
  State<missConnectAlert> createState() => _missConnectAlertState();
}

class _missConnectAlertState extends State<missConnectAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 418,
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                '지금 검색을 취소하면 햇살을 보낼 수 없어요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF727272),
                                  fontSize: 25,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.03,
                                ),
                              ),
                              SizedBox(height: 20),
                              const Text(
                                '연결을 취소할까요?.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFF8D4D),
                                  fontSize: 25,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.03,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                child: const Text(
                                  '예, 연결을 취소합니다',
                                  style: TextStyle(
                                    color: Color(0xFF4B4A48),
                                    fontSize: 25,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                onPressed: (){
                                  null
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) => AccountInfo()));
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(346, 73),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: Color(0xFFFFD852),
                                ),
                              ),
                              SizedBox(height: 20), // 간견주기 왜 안됨?
                              ElevatedButton(
                                child: const Text(
                                  '아니요, 연결을 계속합니다',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w50결,
                                    height: 0,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(346, 73),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: Color(0xFF4B4A48),
                                ),
                              ),
                            ],

                          )
                      ),
                    );
                  },
                );
              },
              child: Text('alret'),
            )
          ],
        ),
      ),
    );
  }

}
