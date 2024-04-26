import 'package:suntown/main/signingUp/Login/KakaoLogin/main_view.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_login.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:flutter/material.dart';

import 'package:suntown/utils/HttpGet.dart';
import '../../User/User.dart';
import '../../User/UserAccountInfo.dart';

class signingUP extends StatefulWidget {
  const signingUP({super.key});

  @override
  State<signingUP> createState() => _signingUPState();
}


class _signingUPState extends State<signingUP> {


  final viewModel = MainViewModel(KakaoLogin());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                      child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 75,
                            ),
                            SizedBox(
                              width: 343,
                              height : 72,
                              child: Text(
                                '로그인하고\n매듭창고 시작하기.',
                                style: TextStyle(
                                  color: Color(0xFF4B4A48),
                                  fontSize: 25,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 236,
                            ),
                            InkWell(
                              onTap: () {
                                viewModel.login();
                                //화면 갱신
                                setState(() {});
                                print("버튼 클릭");
                              },
                              child: Image.asset("assets/images/kakao_login_large_wide.png"),
                            ),
                          ]
                      )
                  )
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => defaultAccount()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD852),
                  minimumSize: Size.fromHeight(50),

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
                child: const Text("다음"),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
