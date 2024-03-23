import 'package:flutter/material.dart';

class CheckExchange extends StatefulWidget {
  const CheckExchange({super.key});

  @override
  State<CheckExchange> createState() => _CheckExchangeState();
}

class _CheckExchangeState extends State<CheckExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('계좌 잔액 확인하는 화면'),
            ]
        ),
      ),
    );
  }
}
