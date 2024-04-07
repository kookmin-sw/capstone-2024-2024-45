import 'package:flutter/material.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body : Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 40),
        child : Container(
          decoration: BoxDecoration(
            border: Border.all( // 선 설정
            color: Colors.black, // 선 색상
            width: 1.0, // 선 두께
            ),
          ),
        )
      )
    );
  }
}
