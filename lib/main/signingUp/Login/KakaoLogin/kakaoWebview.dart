import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
        onLoadStop: (controller, url) async {
          if (url != null && url.toString().startsWith("http://localhost:3000/auth/kakao")) {

            KakaoAuthService(clientId: clientId, redirectUri: url.toString()).getCodeAndSendToServer();
          }
        },
      ),
    );
  }
}