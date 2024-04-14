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
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onTap(widget.value);
      },
      child: Container(
        width :123.429,
        height: 60,
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
