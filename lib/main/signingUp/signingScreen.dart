import 'package:suntown/main/signingUp/Login/KakaoLogin/main_view.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_login.dart';
import 'package:suntown/main/signingUp/nickNameScreen.dart';
import 'package:flutter/material.dart';

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

              InkWell(
                onTap: () {
                  viewModel.login();
                  //화면 갱신
                  setState(() {});
                  print("버튼 클릭");
                },
                child: Image.asset("assets/images/kakao_login_large_wide.png"),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => nickName()));
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
