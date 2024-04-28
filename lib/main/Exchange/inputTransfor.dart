// 송금할 금액을 입력하는 곳
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:suntown/User/ScannedUserAmountInfo.dart';
import 'package:suntown/main/CustomKeyboard/KeyboardKeys.dart';
import 'package:suntown/main/Exchange/checkExchange.dart';

import '../../User/ScannedUser.dart';
import '../../User/SendApi.dart';
import '../../User/User.dart';
import '../../utils/HttpGet.dart';
import '../../utils/screenSizeUtil.dart';

class InputTransfor extends StatefulWidget {
  final String userId; // 생성자에 userId 추가

  const InputTransfor({Key? key, required this.userId}) : super(key: key);

  @override
  State<InputTransfor> createState() => _InputTransforState();
}

class _InputTransforState extends State<InputTransfor> {
  late ScannedUser scannedUser;
  late SendApi sendData;
  late ScannedUserAccountInfo scannedUserAccountInfo; //나중에 이것도 받아오는 fetch 작성해야 함

  String alerttext = "";
  int balance = 1000000; // 잔액 설정, 나중에 api 연동 값으로 바꿀 예정
  String amount = '';
  int parsedAmount = 0;
  bool isDataLoaded = false; // 데이터가 로드되었는지 여부를 나타내는 변수 추가
  //키보드 요소 추가
  List<List<dynamic>> keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [
      '00',
      '0',
      Icon(
        Icons.keyboard_backspace,
        size: 30,
      )
    ],
  ];

  @override
  void initState() {
    super.initState();
    sendData = SendApi();
    scannedUser = ScannedUser(); // UserData 인스턴스 생성
    scannedUserAccountInfo = ScannedUserAccountInfo();
    _fetchUserData(); // initState에서 데이터 가져오도록 호출
    // _fetchAccountData();
  }

  // API 요청을 보내어 사용자 데이터를 가져오는 메서드
  Future<void> _fetchUserData() async {
    // userId를 사용하여 API 요청을 보냄
    Map<String, dynamic> userdata =
    await httpGet(path: '/api/users/${widget.userId}'); //여기서 임호화된 데이터를 보내야함
    // API 응답을 통해 사용자 데이터 업데이트

    if (userdata.containsKey('statusCode') && userdata['statusCode'] == 200) {
      // 사용자 데이터를 업데이트
      scannedUser.initializeData(userdata["data"]);

      // setState를 호출하여 화면을 다시 그림
      setState(() {
        isDataLoaded = true; // 데이터가 로드되었음을 표시
      });
    } else {
      // API 요청 실패 처리
      debugPrint('Failed to fetch user data');
    }
  }

  // // API 요청을 보내어 사용자 데이터를 가져오는 메서드
  // Future<void> _fetchAccountData() async {
  //   // userId를 사용하여 API 요청을 보냄
  //   Map<String, dynamic> userdata =
  //   await httpGet(path: '/api/users/${scannedUser.id}'); //여기서 임호화된 데이터를 보내야함
  //   // API 응답을 통해 사용자 데이터 업데이트
  //
  //   if (userdata.containsKey('statusCode') && userdata['statusCode'] == 200) {
  //     // 사용자 데이터를 업데이트
  //     scannedUserAccountInfo.initializeData(userdata["data"]);
  //
  //     // setState를 호출하여 화면을 다시 그림
  //     setState(() {
  //       isDataLoaded = true; // 데이터가 로드되었음을 표시
  //     });
  //   } else {
  //     // API 요청 실패 처리
  //     debugPrint('Failed to fetch user data');
  //   }
  // }

  onKeyTap(val) {
    if (val == "0" && amount.length == 0) {
      return;
    }

    if (val == "00" && amount.length == 0) {
      return;
    }
    parsedAmount = int.parse(amount + val);

    if (balance < parsedAmount) {
      setState(() {
        alerttext = '내가 가진 매듭보다 많아요!';
      });
      return;
    }

    setState(() {
      amount = amount + val;
      parsedAmount = int.parse(amount);
    });
  }

  onBackspacePress() {
    if (amount.length == 0) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
      parsedAmount = int.parse(amount.isEmpty ? '0' : amount);
      alerttext = ""; // 백스페이스를 누르면 초과 텍스트를 다시 지움
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Center(
        child: Row(
          //키보드에 다음가 같이 center 적용
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: x.map(
                (y) {
              return KeyboardKeys(
                  label: y,
                  value: y,
                  onTap: (val) {
                    if (val is Widget) {
                      onBackspacePress();
                    } else {
                      onKeyTap(val);
                    }
                  });
            },
          ).toList(),
        ),
      ),
    )
        .toList();
  }

  renderAmount(double screenWidth, double screenHeight) {
    String display = "입력해 주세요";
    String nickname = scannedUser.lastName; //api에서 가져온 닉네임 활용
    String printNickname = "$nickname 님에게"; //닉네임 잘 받아오는지 보기

    TextStyle nameTextStyle = TextStyle(
      fontSize: screenWidth * 0.075,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    TextStyle textStyle = TextStyle(
      fontSize: screenWidth * 0.075,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    if (this.amount.length > 0) {
      NumberFormat f = NumberFormat("#,###");
      display = "${f.format(int.parse(amount))}매듭";
      textStyle = textStyle.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  // 여기에 프로필 이미지 설정
                  radius: screenWidth * 0.1, // 이미지 크기 설정
                  backgroundImage: NetworkImage(scannedUser.avatar), // 네트워크 이미지 사용 예시
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Text(
                  printNickname,
                  style:  TextStyle(
                    fontSize: screenWidth * 0.075,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "얼마 만큼의 매듭을 보낼까요?",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Text(
                  display,
                  style: textStyle,
                ),
                Text(
                  "잔액 : ${NumberFormat("#,###").format(balance)} 매듭",
                  //api 값 가져오기
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Color(0xFF727272),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Text(
                  alerttext,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.red,
                  ),
                )
              ]),
        ));
  }

  renderConfirmButton(double screenWidth, double screenHeight) {
    //버튼
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: amount.length > 0
                  ? () {
                // 버튼 활성화 여부에 따라 onPressed 설정
                sendData.amount = int.parse(amount); //입력 받아서 넣을 수 있게
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckExchange()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                disabledBackgroundColor: Colors.grey[400],
                disabledForegroundColor: Colors.grey,
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFF4B4A48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ), // 버튼 비활성화
              child: Text(
                "확인",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.055,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    // userData 정보가 설정되었다면 화면을 그림
    if (!isDataLoaded) {
      // 데이터가 로드되지 않았으면 로딩 화면을 보여줍니다.
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 데이터가 로드되었다면 화면을 그립니다.
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            renderAmount(screenWidth,screenHeight),
            ...renderKeyboard(),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            renderConfirmButton(screenWidth,screenHeight),
          ]),
        ),
      ),
    );
  }
}
