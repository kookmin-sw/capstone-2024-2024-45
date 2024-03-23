import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFBD3), //0xff +
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Lottie.asset("assets/lottie/sun.json"),
              ),
              SizedBox(height: 20),
              Text(
                '햇살마을',
                style: TextStyle(fontSize: 55),
              ),
            ],
          ),
        ),
    );
  }
}
