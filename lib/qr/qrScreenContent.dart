import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qrScreenProvider.dart';

class QrScreenContent extends StatefulWidget {
  @override
  State<QrScreenContent> createState() => _QrScreenContentState();
}

class _QrScreenContentState extends State<QrScreenContent> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QrScreenProvider>(context);
    final scannerUser = provider.scannerUser;

    // 타이머가 만료되었는지 확인하여 버튼 활성화 여부 결정
    bool timerExpired = provider.expirationTime.isBefore(DateTime.now());


    return Container(
      decoration: BoxDecoration(color: Color(0xFFFFE2E2)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 306,
                height: 62,
                decoration: BoxDecoration(color: Color(0xFFFFF6F6)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${scannerUser.lastName}의 매듭 코드",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 270,
                height: 270,
                child: provider.dataupdate
                    ? QrImageView(
                        data: "helloworld://send?id=${scannerUser.id}&datetime=${scannerUser.dateTime}", //여기서 url을 구성해서 넣어야 한다.
                        embeddedImage:
                            NetworkImage(scannerUser.avatar as String),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(50, 50),
                        ),
                        version: QrVersions.auto,
                        size: 270,
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: timerExpired ? Colors.white : Colors.black,
                        ),
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: timerExpired ? Colors.white : Colors.black,
                        ),
                      )
                    : Lottie.asset(
                        "assets/lottie/loading.json"), // 데이터가 없는 경우 로딩 로티 표시
              ),
              SizedBox(height: 20),
              timerExpired
              ? ElevatedButton(
                onPressed: () {
                  provider.refreshQrData(); // refreshQrData() 실행 완료 후에 QrImageView 표시
                },
                      child: const Text(
                        '매듭코드 다시 발급받기',
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 25,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(346, 50),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xFFFFD852),
                      ),
                    )
                  : Text(
                      '매듭 코드 변경까지 : ${provider.expirationTime.difference(DateTime.now()).inMinutes}분 ${provider.expirationTime.difference(DateTime.now()).inSeconds % 60}초',
                      style: TextStyle(fontSize: 20),
                    ),
              SizedBox(height: 5), //임시
              Text(
                  scannerUser.dateTime
              ),
            ],
          ),
        ),
      ),
    );
  }
}
