import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:suntown/qr/qrScreen.dart';

import '../User/test/testAccountData.dart';
import '../main/alert/apiFail/ApiRequestFailAlert.dart';
import '../utils/screenSizeUtil.dart';
import 'qrScreenProvider.dart';

class QrScreenContent extends StatefulWidget {
  @override
  State<QrScreenContent> createState() => _QrScreenContentState();
}

class _QrScreenContentState extends State<QrScreenContent> {
  QrScreenProvider qrScreenProvider = QrScreenProvider();
  late TestAccountData testAccountData;

  @override
  void initState() {
    super.initState();
    qrScreenProvider.errorStream.listen((error) {
      //에러 핸들러..동작 하는지는 미지수(test 필)
      ApiRequestFailAlert.showExpiredCodeDialog(context, QrScreen());
    });
    testAccountData = TestAccountData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    final provider = Provider.of<QrScreenProvider>(context);
    // final user = provider.user;
    final secretData = provider.secretScannedUserData;

    // 타이머가 만료되었는지 확인하여 자동 화면 변경
    bool timerExpired = provider.expirationTime.isBefore(DateTime.now());

    if (timerExpired) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          provider.refreshQrData();
        });
      });
    }

    // 위젯을 빌드할 때마다 권한 상태를 업데이트

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.57,
      decoration: BoxDecoration(color: Color(0xFFF6E8E3)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.57 * 0.1,
                  decoration: BoxDecoration(color: Color(0xFFD3C2BD)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${testAccountData.username}의 타임코드",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF624A43),
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        provider.dataupdate
                            ? QrImageView(
                                data:
                                    "helloworld://send?hmac=${secretData.hmac}&data=${secretData.incodingData}",
                                version: QrVersions.auto,
                                size: screenHeight * 0.6 * 0.6,
                                dataModuleStyle: QrDataModuleStyle(
                                  dataModuleShape: QrDataModuleShape.square,
                                  color: Colors.black,
                                ),
                                eyeStyle: QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: Colors.black,
                                ),
                              )
                            : Lottie.asset("assets/lottie/loading.json"),
                      ]),
                ),
              ),
              Text(
                  '타임코드 변경 : ${provider.expirationTime.difference(DateTime.now()).inMinutes}분 ${provider.expirationTime.difference(DateTime.now()).inSeconds % 60}초',
                  style: TextStyle(
                    fontSize: 23,
                    color: Color(0xFF4B4A48),
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
