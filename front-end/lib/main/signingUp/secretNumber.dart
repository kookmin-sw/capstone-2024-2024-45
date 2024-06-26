import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:suntown/main/signingUp/openAccount.dart';

class secretNumber extends StatefulWidget {
  const secretNumber({super.key});

  @override
  State<secretNumber> createState() => _secretNumberState();
}

class _secretNumberState extends State<secretNumber> {
  String nickName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                      child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 75,
                            ),
                            SizedBox(
                              width: 119,
                              height: 25,
                              child: Text(
                                '2. 창고만들기',
                                style: TextStyle(
                                  color: Color(0xFF4B4A48),
                                  fontSize: 17,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 343,
                              height : 51,
                              child: Text(
                                '비밀번호를 입력해주세요.',
                                style: TextStyle(
                                  color: Color(0xFF4B4A48),
                                  fontSize: 25,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 77,
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                // 최대 문자 길이
                                maxLength :6,
                                // obscureText: true, 비밀번호 작성할 떄
                                onChanged: (text) {
                                  setState(() {
                                    nickName = text;
                                    print(nickName);
                                  });
                                },
                                decoration : InputDecoration(
                                  hintText : '간편 비밀번호 입력',
                                ),
                                obscureText: true,
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: () async {
                  var data = {
                    'nickName' : nickName,
                  };
                  var body = jsonEncode(data);
                  http.Response _res = await http.post(Uri.parse("https://reqres.in/api/users"),
                      headers: {"Content-Type" : 'application/json'},
                      body :body
                  );
                  print(_res.statusCode);
                  print(_res.body);

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => openAccount())
                  // );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B4A48),
                  foregroundColor:Colors.white,
                  minimumSize: Size.fromHeight(73),

                  textStyle: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 0,

                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("다음"),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

