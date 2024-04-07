import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/startScreen.dart';

void main() {
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
                 MaterialPageRoute(builder: (context) => startScreen()));
             },
            child: const Text("회원가입"),
         ),
      ),
    );
  }
}


