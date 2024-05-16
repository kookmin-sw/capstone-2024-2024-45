import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:suntown/User/scannedUserData/ScannedUser.dart';
import '../User/test/testAccountData.dart';
import '../main/Exchange/inputTransfor.dart';
import '../main/Exchange/minutesInputTransfor.dart';
import '../main/alert/apiFail/ApiRequestFailAlert.dart';
import '../main/alert/qrTimeOutDialog.dart';
import '../utils/api/info/qrScanPost.dart';
import '../utils/screenSizeUtil.dart';

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
  late ScannedUser scannedUser;
  late bool dataUpdate;
  late bool pushPopup;

  @override
  void initState() {
    super.initState();
    scannedUser = ScannedUser();
    dataUpdate = false;
    pushPopup = false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      appBar: AppBar(
        title: Center(
          child: Text(
            "시간 은행",
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          // 빈 아이콘을 추가하여 빈 공간을 만듭니다.
          IconButton(
            icon: Container(),
            onPressed: () {},
          )
        ],
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
                        "시간을 보냅니다!",
                        style: TextStyle(
                            fontSize: 30
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "시간을 보내고 싶은 이웃의",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF7D303D),
                          fontFamily: 'Noto Sans KR',
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF7D303D),
                              fontFamily: 'Noto Sans KR'),
                          children: <TextSpan>[
                            TextSpan(
                              text: '"타임코드"',
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
          borderColor: Color(0xFF2C533C),
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
      setState(() async {
        result = scanData;
        if (result != null) {
          // QR 코드에서 URL을 받아옴
          String? str = result!.code;
          // URL에서 특정 형식을 가진 경우에만 송금 페이지로 이동
          if (str != null && str.startsWith("helloworld://send")) {
            // 카메라 일시 중지
            controller.pauseCamera();
            // InputTransfor 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InputTransfor(url: str)),
            ).then((_) {
              // 페이지에서 돌아온 후에 카메라 재시작
              controller.resumeCamera();
            });
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
