import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import 'package:suntown/main/Exchange/finishExchange.dart';
import 'package:suntown/main/refund/finishRefund.dart';
import 'package:suntown/utils/api/refund/refundPost.dart';

import '../../User/SendAmount.dart';
import '../../User/refundUserData/RefundUser.dart';
import '../../User/userData/User.dart';
import '../../utils/api/info/sendPost.dart';
import '../../utils/screenSizeUtil.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class LoadingRefund extends StatefulWidget {

  const LoadingRefund({Key? key}) : super(key: key);

  @override
  State<LoadingRefund> createState() => _LoadingExchangeState();
}

class _LoadingExchangeState extends State<LoadingRefund> {
  late int amount;
  late RefundUser refundUser;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    refundUser = RefundUser();
    fetchData(refundUser.transId ,refundUser.expectedAmount,refundUser.inquire);
  }

  Future<void> fetchData(int transId, String expectedAmount, String inquire) async {
    final String? token = await secureStorage.read(key: 'accessToken');
    if (token != null) {
      try {
        // API 요청을 보냅니다.
        final value = await refundPost(
            transId: transId, expectedAmount: expectedAmount, inquire: inquire, token: token);

        if (value['statusCode'] == 200) {
          // 성공적으로 응답을 받았을 때 FinishExchange 화면으로 이동합니다.
          if (value["status"] == 201) { //검증 완료
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinishRefund()),
            );
          }
        } else {
          ApiRequestFailAlert.showExpiredCodeDialog(context, LoadingRefund());
          debugPrint('서버 에러입니다. 다시 시도해주세요');
        }
      } catch (e) {
        ApiRequestFailAlert.showExpiredCodeDialog(context, LoadingRefund());
        debugPrint('API 요청 중 오류가 발생했습니다: $e');
      }
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
          '송금 ${refundUser.inquire} 요청이',
            style: TextStyle(
              color: Color(0xFF7D303D),
              fontSize: 30,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.bold,
            ),
                textAlign: TextAlign.center,
              ),
              Text(
                '진행 중입니다....',
                style: TextStyle(
                  color: Color(0xFF727272),
                  fontSize: 30,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset("assets/lottie/loading.json"),
              ),
              SizedBox(height:  screenHeight * 0.01),
              Text(
                '화면을 끄지 말고',
                style: TextStyle(
                  color: Color(0xFF4B4A48),
                  fontSize: 25,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                '잠시 기다려주세요..',
                style: TextStyle(
                  color: Color(0xFF4B4A48),
                  fontSize: 25,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}