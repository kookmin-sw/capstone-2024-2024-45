import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/checkExchange.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({super.key});

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('choose my account')),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                title: Text('계좌1'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckExchange()
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
