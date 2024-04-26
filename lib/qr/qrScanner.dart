import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:suntown/main/mainAccount.dart';
import '../main/Exchange/inputTransfor.dart';
import '../main/alert/qrTimeOutDialog.dart';

class qrScanner extends StatefulWidget {
  const qrScanner({super.key});

  @override
  State<qrScanner> createState() => _qrScannerState();
}

class _qrScannerState extends State<qrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      appBar: AppBar(
        title: Text("flutter_qr"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "매듭을 보냅니다!",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "매듭을 보내고 싶은 이웃의",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFFFF8D4D),
                          fontFamily: 'Noto Sans KR',
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFFFF8D4D),
                              fontFamily: 'Noto Sans KR'),
                          children: <TextSpan>[
                            TextSpan(
                              text: '"매듭코드"',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '를',
                            ),
                            TextSpan(
                              text: '찍어주세요!',
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(flex: 3, child: _buildQrView(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFFFF8D4D),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          // QR 코드에서 URL을 받아옴
          String? url = result!.code;
          // URL에서 특정 형식을 가진 경우에만 송금 페이지로 이동
          if (url != null && url.startsWith("helloworld://send")) {
            // URI 파싱
            Uri uri = Uri.parse(url);
            // datetime 쿼리 매개변수 값 가져오기
            String datetime = uri.queryParameters["datetime"]!;
            String userId = uri.queryParameters["id"]!;
            // String으로 표현된 dateTime을 DateTime 객체로 변환
            DateTime parsedDateTime = DateTime.parse(datetime);
            Duration difference = now.difference(parsedDateTime);

            // 차이가 2분 미만인지 확인
            if (difference.inSeconds < 0) {
              print("유효한 코드!");
              //유효시간보다 많아지면, 즉 now가 더 커져서 양 지난 것이다.
              // 송금 페이지로 이동하면서 id 값을 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InputTransfor(userId: userId)),
              ).then((_) {
                controller.resumeCamera();
              });
            } else {
              // 1분 이상인 경우, alert dialog
              QrTimeOutDialog.showExpiredCodeDialog(context, () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                // 재스캔
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => qrScanner()),
                );
              });
            }
            // 화면으로 이동하기 전에 카메라 일시 중지
            controller.pauseCamera();
          }
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
