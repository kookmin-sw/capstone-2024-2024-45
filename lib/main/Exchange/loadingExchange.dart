import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import 'package:suntown/main/Exchange/finishExchange.dart';
import 'package:suntown/utils/api/send/sendPost.dart';

import '../../User/SendAmount.dart';
import '../../User/userData/User.dart';
import '../../utils/screenSizeUtil.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class LoadingExchange extends StatefulWidget {
  const LoadingExchange({Key? key}) : super(key: key);

  @override
  State<LoadingExchange> createState() => _LoadingExchangeState();
}

class _LoadingExchangeState extends State<LoadingExchange> {
  User userData = User();
  SendApi sendApi = SendApi();
  ScannedUser scannedUser = ScannedUser();

  @override
  void initState() {
    super.initState();
    // 데이터를 가져오는 함수 호출. init 부분에서 시행한다.
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // API 요청을 보냅니다.
      final value = await sendPost(senderAccountId: sendApi.sendAccountId, receiverAccountId: sendApi.receiverAccountId, amount: sendApi.amount);

      if (value['statusCode'] == 200) {
        // 성공적으로 응답을 받았을 때 FinishExchange 화면으로 이동합니다.
        if(value["status"] == 201){ //검증 완료
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FinishExchange()),
          );
        }
      } else {
        ApiRequestFailAlert.showExpiredCodeDialog(context,LoadingExchange());
        debugPrint('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(context,LoadingExchange());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return WillPopScope(
      onWillPop: () async {
        return false; // 화면을 떠나지 않도록 false를 반환합니다.
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '화면을 끄지 마시고',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '잠시 기다려 주세요!',
                style: TextStyle(
                  color: Color(0xFF727272),
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.025),
              SizedBox(
                height: screenWidth * 0.5,
                width: screenWidth * 0.5,
                child: Lottie.asset("assets/lottie/loading.json"),
              ),
              SizedBox(height:  screenHeight * 0.025),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${scannedUser.name}',
                      style: TextStyle(
                        color: Color(0xFF7D303D),
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '님에게',
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '매듭을 보내고 있습니다..',
                style: TextStyle(
                  color: Color(0xFF4B4A48),
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}