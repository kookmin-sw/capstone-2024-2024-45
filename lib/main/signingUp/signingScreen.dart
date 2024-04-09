import 'package:suntown/main/signingUp/Login/KakaoLogin/main_view.dart';
import 'package:suntown/main/signingUp/Login/KakaoLogin/kakao_login.dart';
import 'package:flutter/material.dart';

// import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

// void main() {
//   // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
//   WidgetsFlutterBinding.ensureInitialized();
//   // runApp() 호출 전 Flutter SDK 초기화
//   KakaoSdk.init(
//     nativeAppKey: '731616c5419324d656e34dc0a0f35a85',
//   );
//   runApp(const MyApp());
// }

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
              Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ""),
              Text(
                '${viewModel.isLogined}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                  onPressed: () async{
                    viewModel.login();
                    //화면 갱신
                    setState(() {
                    });
                  }, child: const Text("Login")
              ),
              ElevatedButton(
                  onPressed: () async {
                    viewModel.logout();
                    setState(() {
                    });
                  }, child: const Text("Logout")),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
