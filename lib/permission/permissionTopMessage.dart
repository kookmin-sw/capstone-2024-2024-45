import 'package:flutter/material.dart';

class PermissionTopMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "임시",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}