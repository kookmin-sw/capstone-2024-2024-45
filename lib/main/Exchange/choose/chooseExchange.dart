
import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/inputTransfor.dart';

class ChooseExchange extends StatefulWidget {
  const ChooseExchange({super.key});

  @override
  State<ChooseExchange> createState() => _ChooseExchangeState();
}

class _ChooseExchangeState extends State<ChooseExchange> {
  List<String> people = ['홍길동', '김좌진', '유관순']; // 예시로 3명의 사람 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('송금을 누구에게 할지 정하는 곳 ')),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(people[index]),
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
          );
        },
      ),
    );
  }
}
