import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/screenSizeUtil.dart';
import 'qrScreenProvider.dart';

class QrScreenContent extends StatefulWidget {
  @override
  State<QrScreenContent> createState() => _QrScreenContentState();
}

class _QrScreenContentState extends State<QrScreenContent> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    final provider = Provider.of<QrScreenProvider>(context);
    final scannerUser = provider.scannerUser;

    // 타이머가 만료되었는지 확인하여 버튼 활성화 여부 결정
    bool timerExpired = provider.expirationTime.isBefore(DateTime.now());

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.6,
      decoration: BoxDecoration(color: Color(0xFFFFE2E2)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(color: Color(0xFFFFF6F6)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${scannerUser.lastName}의 매듭 코드",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF4B4A48),
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 10,
                  child: Center(
                    child: provider.dataupdate
                        ? Container(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.4,
                            child: QrImageView(
                              data:
                                  "helloworld://send?id=${scannerUser.id}&datetime=${scannerUser.dateTime}",
                              embeddedImage:
                                  NetworkImage(scannerUser.avatar as String),
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                size: Size(
                                    screenWidth * 0.15, screenWidth * 0.15),
                              ),
                              version: QrVersions.auto,
                              size: screenWidth * 0.5,
                              dataModuleStyle: QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color:
                                    timerExpired ? Colors.white : Colors.black,
                              ),
                              eyeStyle: QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color:
                                    timerExpired ? Colors.white : Colors.black,
                              ),
                            ),
                          )
                        : Lottie.asset("assets/lottie/loading.json"),
                  ),
                ),
                Spacer(),
                timerExpired
                    ? ElevatedButton(
                        onPressed: () {
                          provider
                              .refreshQrData(); // refreshQrData() 실행 완료 후에 QrImageView 표시
                        },
                        child: const Text(
                          '매듭코드 다시 발급받기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(screenWidth * 0.85, screenHeight * 0.08),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Color(0xFF4B4A48),
                        ),
                      )
                    : Text(
                        '매듭 코드 변경 : ${provider.expirationTime.difference(DateTime.now()).inMinutes}분 ${provider.expirationTime.difference(DateTime.now()).inSeconds % 60}초',
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
      ),
    );
  }
}
