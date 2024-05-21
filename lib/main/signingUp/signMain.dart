import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:suntown/firebase_options.dart';


void main() async{
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'ba30c405908be1afda46343b5b73b363',
  );
  // Firebase 앱이 이미 초기화되었는지 확인
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  await Firebase.initializeApp(
      name: "dev project",
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Signing(),
    );
  }
}

class Signing extends StatefulWidget {
  const Signing({super.key});

  @override
  State<Signing> createState() => _SigningState();
}

class _SigningState extends State<Signing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3),
      body: Center(
        // mainAxisAlignment: MainAxisAlignment.center,
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => signingUP()));
          },
          child: const Text("회원가입"),
        ),
      ),
    );
  }
}

