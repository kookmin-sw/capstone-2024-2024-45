import 'package:flutter/material.dart';

class ExitExchangeAlert extends StatefulWidget {
  const ExitExchangeAlert({super.key});

  @override
  State<ExitExchangeAlert> createState() => _ExitExchangeAlertState();
}

class _ExitExchangeAlertState extends State<ExitExchangeAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Text("송금 취소 alert"),
    );
  }
}
