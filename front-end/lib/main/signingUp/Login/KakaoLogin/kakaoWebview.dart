import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:suntown/main/mainAccount.dart';

import 'kakao_login.dart';

class KakaoLoginWebView extends StatelessWidget {
  final String initialUrl;
  final String clientId;

  const KakaoLoginWebView({Key? key, required this.initialUrl, required this.clientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(Uri.parse(initialUrl).toString()), // Uri 객체를 String으로 변환하여 사용
        ),
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(useHybridComposition: true)),
        onLoadStop: (controller, url) {
          if (url != null && url.toString().startsWith("http://localhost:3000/auth/kakao")) {
            // KakaoAuthService의 getCodeAndSendToServer 메서드 호출 후 반환된 Future<bool> 값을 처리합니다.
            KakaoAuthService(clientId: clientId, redirectUri: url.toString()).getCodeAndSendToServer()
                .then((state) {
              if (state) {
                // state가 true이면 WebView를 닫고 defaultAccount 화면으로 이동합니다.
                Navigator.pop(context);
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => defaultAccount()));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainAccount()));
              }
            });
          }
        },
      ),
    );
  }
}
