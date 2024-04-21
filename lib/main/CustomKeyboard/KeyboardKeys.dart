import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardKeys extends StatefulWidget {
  final dynamic label;
  final dynamic value; //값
  final ValueSetter<dynamic> onTap;

  KeyboardKeys({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<KeyboardKeys> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKeys> {
  renderLabel(){
    if(widget.label is Widget){
      return widget.label;
    }
    return Text(
      widget.label,
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){
        widget.onTap(widget.value);
      },
      child: Container(
        width: screenWidth * 0.28, // 화면 너비의 50%
        height: screenHeight * 0.08, // 화면 높이의 10%
        child: AspectRatio(
          aspectRatio: 2,
          child: Center(
            child : renderLabel(),
          ),
        ),
      ),
    );
  }
}
