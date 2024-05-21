import 'package:firebase_auth/firebase_auth.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/login_out.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import '../firebase_auth_remote_data_source.dart';
import 'package:http/http.dart' as http;

class MainViewModel{
  final _firebaseAuthDataSource = FirebaseAuthRemoteDataSource();
  final SocialLogin _socialLogin;
  final url = Uri.https('kapi.kakao.com', '/v2/user/me');
  // 처음에 로그인은 fasle로 설정
  bool isLogined = false;
  kakao.User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    print(isLogined);
    if(isLogined){
      print('isLogined 진입');
      // 현재 로그인된 유저 정보를 가지고옴
      user = await kakao.UserApi.instance.me();
      print('user------------_$user');
      print(user != null);
      String uid = user!.id.toString();
      String? email = user!.kakaoAccount!.email!;
      print('user.id-----------$uid ');
      print('user.email-----------$email');

      // 서버로 user정보 보내고 customToken 받아냄.
      final customToken = await _firebaseAuthDataSource.createCustomToken({
        'uid' : uid.toString(),
        'displayName' : user!.kakaoAccount!.profile!.nickname,
        'email' :email,
      });
      print("customToken ---------------$customToken");
      try {
        // FirebaseAuth로 사용자를 Custom Token으로 인증
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCustomToken(customToken);
        User? user = userCredential.user;
        print('userCredential-------------\n $userCredential');
        if (user != null) {
          String uid = user.uid;
          String? email = user.email;
          print("User UID: $uid");
          if (email != null) {
            print("User Email: $email");
          } else {
            print("User email is not available.");
          }
        }
      }catch (e){
        print("Error signing in with custom token: $e");}
      }

  }

  Future logout() async{
    await _socialLogin.logout();
    isLogined = false;
    user = null;
    print('로그아웃 완료');
  }

}