// 선택한 계좌 화면
import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/connectBlue.dart';
import 'package:suntown/main/saving/savingHistory/savingHistory.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: [
            const Expanded(
              flex: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 나눔 장려 문구 -----------------
                    Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Row(
                            children: [
                              Text("이모지"),
                              Spacer(),
                              //말풍선 텍스트
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child :
                                    Column(
                                      children: [
                                        Text(
                                          "오늘도 나눔에 앞장서는" + "       ",
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          "아름다운 당신을 응원합니다",
                                          textAlign: TextAlign.left,
                                        )
                                      ],
                                    ),
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),

                  // 계좌정보 표시 하는곳 -----------------
                  Center(
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '경로당 창고',
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  '1300',
                                  style: TextStyle(fontSize: 50),
                                ),
                                Text(
                                  '햇살',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),

            // 송금 버튼 -----------------
            SizedBox(
              // SizedBox 대신 Container를 사용 가능
              width: 346,
              height: 73,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConnectBlue()));
                },
                child: Text('햇살 보내기'),
              ),
            ),

            // 거래내역 확인 버튼 -----------------
            SizedBox(
              height: 20,
            ),
            SizedBox(
              // SizedBox 대신 Container를 사용 가능
              width: 346,
              height: 73,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Savinghistory()));
                },
                child: Text('거래 확인하기'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
