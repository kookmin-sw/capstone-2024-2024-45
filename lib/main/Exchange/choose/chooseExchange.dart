
import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/inputTransfor.dart';

class ChooseExchange extends StatefulWidget {
  const ChooseExchange({super.key});

  @override
  State<ChooseExchange> createState() => _ChooseExchangeState();
}

class _ChooseExchangeState extends State<ChooseExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('송금을 누구에게 할지 정하는 곳 ')),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                title: Text('사람1'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputTransform()
                    ),
                  );
                }
              //dense: true,
            ),
          ),
        ],
      ),
    );
  }
}
