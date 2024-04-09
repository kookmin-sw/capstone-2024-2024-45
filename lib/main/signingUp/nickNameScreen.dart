import 'package:flutter/material.dart';
// import 'package:suntown/main/signingUp/nickNameScreen.dart';

class nickName extends StatefulWidget {
  const nickName({super.key});

  @override
  State<nickName> createState() => _nickNameState();
}

class _nickNameState extends State<nickName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(

            children: <Widget>[
              SizedBox(
                width: 97,
                height: 25,
                child: Text(
                  '나가기',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 17,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: 97,
                            height: 25,
                            child: Text(
                              '1. 회원가입',
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
                              '사용하실 별명을 입력해주세요.',
                              style: TextStyle(
                                color: Color(0xFF4B4A48),
                                fontSize: 25,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ]
                    )
                  )
              ),

              ElevatedButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => signingUP()));
                  null;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B4A48),
                  minimumSize: Size.fromHeight(50),

                  textStyle: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    color: Colors.white,
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

