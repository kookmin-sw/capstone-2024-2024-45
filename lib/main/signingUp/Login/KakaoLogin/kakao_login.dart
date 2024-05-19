import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';


class KakaoLogin {
  // late String REST_API_KEY;

  Future<UserCredential?> signInWithKakao() async {
    // REST_API_KEY = await dotenv.get("FLUTTER_APP_REST_API_KEY") ?? '';
    //
    // if (REST_API_KEY.isEmpty) {
    //   // REST_API_KEY가 초기화되지 않았으면 처리
    //   print("REST_API_KEY가 초기화되지 않았음");
    //   return null;
    // }

    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': "1a354a3d4dc989747906944c3c188196",
      'redirect_uri':'http://192.168.219.188:8080/auth/kakao' , //'http://192.168.219.188:8080/auth/kakao'
    });

    try {
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: 'webauthcallback',
      );

      final params = Uri
          .parse(result)
          .queryParameters;
      final code = params['code'];
      print('------------------');
      print(code);
    } catch (e) {
      print(e);
    }

    print("-------------------WebAuth2 로그인 url 확인용--------------");
    print(url);

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "callbackUrlScheme");

    print("-------------------WebAuth2 로그인 확인용--------------");
    print(result);
    final params = Uri.parse(result).queryParameters;
    print(params);

    // 여기에 실제 인증 처리 로직 추가

    return null;  // 아직 완료되지 않은 경우 null 반환
  }
}
