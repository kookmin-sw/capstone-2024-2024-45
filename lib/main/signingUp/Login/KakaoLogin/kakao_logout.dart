import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/utils/api/connect/logoutAuthPost.dart';

class KaKaoLogoutState {
  // FlutterSecureStorage 인스턴스 생성
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> fetchKakaoToken() async {
    final String? token = await secureStorage.read(key: 'accessToken');
    final String? userId = await secureStorage.read(key: 'userId');
    if (token != null && userId != null) {
      try {
        final value = await logoutAuthPost(token: token, userId: userId);
        if (value["statusCode"] == 200) {
          return true;
        }
      } catch (error) {
        print('error-------------$error');
      }
    }
    return false;
  }

  Future<bool> kakaoLogout() async {
    // Auth서버에서 logout
    final status = await fetchKakaoToken();
    if (status) {
      // 토큰 삭제
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'userId');
      await secureStorage.delete(key: 'refreashToken');
      // 로그인 화면으로 이동
      print('로그아웃 완료 ');
      return true;
    } else {
      print('로그아웃 실패');
      return false;
    }
  }
}
