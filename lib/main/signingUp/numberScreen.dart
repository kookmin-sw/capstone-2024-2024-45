import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suntown/main/alert/accountFail/accountCreateFail.dart';
import 'package:suntown/main/alert/singUpFail/userCreateFailAlert.dart';
import 'package:suntown/main/manage/accountInfoManage.dart';

import '../../utils/screenSizeUtil.dart';
import 'accountSuccess.dart';
import '../manage/userInfoManage.dart';

class numberScreen extends StatefulWidget {
  final String username;
  const numberScreen({Key? key, required this.username}) :super(key: key);

  @override
  State<numberScreen> createState() => _numberScreenState(username: username);
}

class _numberScreenState extends State<numberScreen> {
  final String username;
  _numberScreenState({required this.username});

  late TextEditingController _phoneNumberController;
  late String mobile_number;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    mobile_number = _phoneNumberController.text;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false, // 뒤로가기 아이콘 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 왼쪽에 추가할 아이콘
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                              height:  screenHeight * 0.04,
                            ),
                            SizedBox(
                              width: screenWidth * 0.85, // 334
                              height: screenHeight * 0.03, // 25
                              child: Text(
                                '계좌만들기',
                                style: TextStyle(
                                  color: Color(0xFFD3C2BD),
                                  fontSize: 17,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.85,
                              height :  screenHeight * 0.06, // 50
                              child: Text(
                                '전화번호를 입력해주세요.',
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
                              height:  screenHeight * 0.09, //75
                            ),
                            TextField(
                                textAlign: TextAlign.center,
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly, //숫자만!
                                  NumberFormatter(), // 자동하이픈
                                  LengthLimitingTextInputFormatter(13)
                                ],
                                onChanged: (text) {
                                  setState(() {
                                    mobile_number = text;
                                  });
                                },
                                // obscureText: true, 비밀번호 작성할 떄
                                decoration : InputDecoration(
                                  hintStyle: TextStyle(color: Color(0xFFD3C2BD)),
                                  hintText : '전화번호 입력',
                                ),
                              style :TextStyle(
                                color: Color(0xFF624A43),
                                fontSize : 25,
                              ),
                            ),
                          ]
                      )
                  )
              ),
              ElevatedButton(
                onPressed: mobile_number.length ==  13 ? () async {
                  bool userResuccess = await UserInfoManage().fetchUserData(name:username, mobile_number:mobile_number); // user register 성공 여부
                  print("Number스크린에 유저 생성 여부 ---------------------$userResuccess");

                  if (userResuccess){ // 유저 생성이 true이면
                    Map<String, dynamic> account_val = await AccountInfoMange().fetchAccountData( username: username, mobile_number:mobile_number, password: "000000"); // account register 후 값 return
                    final String? account_id = account_val["account_id"]; // account 등록 되면 account_id return 해줌
                    print("Number스크린의 account id---------------------$account_id");
                    bool accountResuccess = account_val["accountInfoUpdate"] == true ? true : false; // account register 성공 여부
                    print("Number스크린에 계좌 생성 여부 ---------------------$accountResuccess");
                    if(accountResuccess){
                      bool connectResuccess = await AccountInfoMange().connectUserAccount(username: username);  // 계좌 생성과 동시에 user 정보와 account 정보 매핑 시켜줌
                      if (connectResuccess){ // 매핑에 성공하면 다음 페이지로
                        print("Number스크린에 계좌와 유저 정보 매핑 여부 ---------------------$connectResuccess");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => accountSuccess()),
                        );
                      }else{
                        accountCreateFail.showExpiredCodeDialog(context, numberScreen(username : username));
                      }
                    }else{
                      accountCreateFail.showExpiredCodeDialog(context, numberScreen(username : username));
                    }
                  }
                  else{
                    UserCreateFailAlert.showExpiredCodeDialog(context, numberScreen(username : username));
                  }
                }
                : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  backgroundColor: const Color(0xFFD3C2BD),
                  foregroundColor:Colors.white,
                  minimumSize: Size.fromHeight(73),

                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.055,

                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                    "다음",
                    style : TextStyle(
                      color: Color(0xFF624A43),
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    )
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}