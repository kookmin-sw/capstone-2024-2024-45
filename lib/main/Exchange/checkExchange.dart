import 'package:flutter/material.dart';
import 'package:suntown/main/Exchange/loadingExchange.dart';
import 'package:suntown/main/alert/exitExchangeAlert.dart';

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
              Text('뫄뫄 님에게', style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 5,),
              Text('1000 햇살을', style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 5,),
              Text('보낼까요?', style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 30,
              ),
              //button
              SizedBox(
                // SizedBox 대신 Container를 사용 가능
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingExchange()));
                  },
                  child: Text('예, 햇살을 보냅니다.'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                // SizedBox 대신 Container를 사용 가능
                width: 346,
                height: 73,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExitExchangeAlert()));
                  },
                  child: Text('아니요, 햇살을 보내지 않습니다.'),
                ),
              ),


            ]
        ),
      ),
    );
  }
}
