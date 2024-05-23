import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:suntown/main/defaultAccount.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'ba30c405908be1afda46343b5b73b363',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    final token = await secureStorage.read(key: 'kakaoToken');
    print('token--------$token');
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => defaultAccount()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signingUP()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3),
      body: Center(
        child:
        // isLoggedIn
        //     ? const CircularProgressIndicator()
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => signingUP()),
            );
          },
          child: const Text("회원가입"),
        ),
      ),
    );
  }
}
