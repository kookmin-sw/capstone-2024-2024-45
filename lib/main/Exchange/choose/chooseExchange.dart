
import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/loadingBluetooth.dart';

class ChooseExchange extends StatefulWidget {
  const ChooseExchange({super.key});

  @override
  State<ChooseExchange> createState() => _ChooseExchangeState();
}

class _ChooseExchangeState extends State<ChooseExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('main')),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
                title: Text('사람1'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingBluetooth()
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
