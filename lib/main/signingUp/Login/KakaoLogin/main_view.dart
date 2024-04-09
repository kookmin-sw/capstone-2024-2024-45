import 'package:suntown/main/signingUp/Login/KakaoLogin/login_out.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class MainViewModel{
  final SocialLogin _socialLogin;
  // 처음에 로그인은 fasle로 설정
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if(isLogined){
      // 현재 로그인된 유저 정보를 가지고옴
      user = await UserApi.instance.me();
    }
  }

  Future logout() async{
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

}