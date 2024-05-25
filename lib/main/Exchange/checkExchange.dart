import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import 'package:suntown/User/scannedUserData/ScannedUserAccountInfo.dart';
import 'package:suntown/User/SendAmount.dart';
import 'package:suntown/main/Exchange/loadingExchange.dart';

import '../../User/test/testAccountData.dart';
import '../../User/userData/User.dart';
import '../../utils/screenSizeUtil.dart';
import '../../utils/time/changeAmountToTime.dart';
import '../../utils/time/changeTimeToAmount.dart';
import '../alert/correctionAlertDialog.dart';

/*
송금 확인 화면
 */

class CheckExchange extends StatefulWidget {
  final int? amount;
  const CheckExchange({Key? key, this.amount}) : super(key: key);

  @override
  State<CheckExchange> createState() => _CheckExchangeState();
}

class _CheckExchangeState extends State<CheckExchange> {
  ScannedUser scannedUser = ScannedUser();

  late SendApi sendApi;
  TestAccountData testAccountData = TestAccountData();

  late int showHours;
  late int showMinutes;

  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();
  ChangeTimeToAmount changeTimeToAmount = ChangeTimeToAmount();


  void fetchData(){ //지금까지 받은 데이터 넣기
    sendApi.amount = widget.amount!;
    sendApi.receiverAccountId = scannedUser.accountId;
    sendApi.sendAccountId = testAccountData.accountNumber; //나중에 user 연동시 변경 예정
  }

  @override
  void initState() {
    super.initState();
    sendApi = SendApi();
    showHours = 0;
    showMinutes = 0;

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    List<int> time = changeAmountToTime.changeAmountToTime(widget.amount!);

    showHours = time[0];
    showMinutes = time[1];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            flex: 50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // 여기에 프로필 이미지 설정
                    radius: 60, // 이미지 크기 설정
                    backgroundImage:
                    NetworkImage(scannedUser.profile), // 네트워크 이미지 사용 예시
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${scannedUser.name}',
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 35,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' 님에게',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 30,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible( //넘칠 경우를 대비...거의 없을듯 싶지만 혹시 모르니
                          child: Text(
                            '${showHours}시간 ${showMinutes}분',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF7D303D),
                              fontSize: 35,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '을',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF4B4A48),
                            fontSize: 30,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.006,
                  ),
                  Text(
                    '보낼까요?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF4B4A48),
                      fontSize: 30,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoadingExchange()));
            },
            child: Text(
              '예, 시간을 보냅니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFDDE9E2),
                fontSize: 20,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Color(0xFF2C533C),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              CorrectAlertDialog.show(context);
            },
            child: Text('수정하고 싶어요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2C533C),
                  fontSize: 20,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                )),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Color(0xFFDDE9E2),
            ),
          ),
        ]),
      ),
    );
  }
}
