
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/main/manage/accountInfoManage.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/main_view.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_login.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakaoWebview.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:flutter/material.dart';

import '../../utils/screenSizeUtil.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'Login/GoogleLogin/google_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class signingUP extends StatefulWidget {
  const signingUP({super.key});

  @override
  State<signingUP> createState() => _signingUPState();
}

class _signingUPState extends State<signingUP> {

  late final String REST_API_KEY;
  late final String redirectUrl;
  late final KakaoAuthService _kakaoAuthService;
  bool isInitialized = false;

  // final viewModel = MainViewModel(KakaoLogin());

  @override
  void initState() {
    super.initState();

    _initialize();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) { // 회원가입된 유저가 있다면
        Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
      }
    });
  }

  Future<void> _initialize() async {
    try {
      print('Loading environment variables...');
      await dotenv.load(fileName: ".env");
      REST_API_KEY = dotenv.get("KAKAO_REST_API_KEY") ?? '';
      redirectUrl = dotenv.get("KAKAO_REDIRECT_URI") ?? '';

      print('REST_API_KEY: $REST_API_KEY');
      print('redirectUrl: $redirectUrl');

      if (REST_API_KEY.isEmpty || redirectUrl.isEmpty) {
        throw Exception('Environment variables not set');
      }

      _kakaoAuthService = KakaoAuthService(clientId: REST_API_KEY, redirectUri: redirectUrl);

      setState(() {
        isInitialized = true;
      });
    } catch (e) {
      print('Error during initialization: $e');
    }
  }

  Future<void> _loginWithKakao() async {
    final String? authorizationUrl = await _kakaoAuthService.requestAuthorizationUrl();
    if (authorizationUrl != null) {
      print("Authorization URL is not null!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KakaoLoginWebView(clientId: REST_API_KEY, initialUrl: authorizationUrl),
        ),
      );
    } else {
      // 인증 URL을 얻지 못한 경우에 대한 처리
      print("Failed to obtain authorization URL!");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    if (!isInitialized) {
      return Scaffold(
        backgroundColor: const Color(0xffFFFDF3),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffFFFDF3),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<User?>(
                    // login 되고 안되고에 따라 새로운 stream이 들어옴.
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.09,
                          ),
                          SizedBox(
                            width: screenWidth * 0.85,
                            height: screenHeight * 0.09,
                            child: Text(
                              '로그인하고\n시간은행 시작하기.',
                              style: TextStyle(
                                color: Color(0xFF4B4A48),
                                fontSize: 25,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.27,
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     await _loginWithKakao();
                          //     // viewModel.login();
                          //     print("카카오 로그인");
                          //   },
                          //   child: Image.asset("assets/images/kakao_login_large_wide.png"),
                          // ),
                          SizedBox(
                            height: screenHeight * 0.024,
                          ),
                          InkWell(
                            onTap: () {
                              signInWithGoogle();
                              print("구글 로그인");
                            },
                            child: Image.asset('assets/images/google_login_wide.png'),
                          ),
                        ],
                      );
                    },
                  ),
                ),

              ),
              // ElevatedButton(
              //   child: const Text(
              //     '다음',
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context) => defaultAccount()));
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
