import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/loadingExchange.dart';
import 'package:suntown/main/accountList/accountInfo.dart';


class CheckExchange extends StatefulWidget {
  const CheckExchange({super.key});

  @override
  State<CheckExchange> createState() => _CheckExchangeState();
}

class _CheckExchangeState extends State<CheckExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            flex: 50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '뫄뫄 님에게',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '1000 햇살을',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '보낼까요?',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            // SizedBox 대신 Container를 사용 가능
            width: 346,
            height: 73,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoadingExchange()));
              },
              child: Text('예, 햇살을 보냅니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(346, 73),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFFFFD852),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            // SizedBox 대신 Container를 사용 가능
            width: 346,
            height: 73,
            child: ElevatedButton(
              onPressed: () {
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
                                '해당 페이지를 벗어나면 햇살을 보낼 수 없어요',
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
                                '송금을 취소할까요?.',
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
                                  '예, 송금을 취소합니다',
                                  style: TextStyle(
                                    color: Color(0xFF4B4A48),
                                    fontSize: 25,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => AccountInfo()));
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
                                  '아니요, 송금을 계속합니다',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
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
              child: Text('아니요, 햇살을 보내지 않습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w500,
                height: 0,
              )
            ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(346, 73),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFF4B4A48),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
