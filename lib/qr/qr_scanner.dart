import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../User/userData.dart';
import '../main/Exchange/inputTransfor.dart';

class qr_scanner extends StatefulWidget {
  const qr_scanner({super.key});

  @override
  State<qr_scanner> createState() => _qr_scannerState();
}

class _qr_scannerState extends State<qr_scanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      appBar: AppBar(
        title: Text("flutter_qr"
        ),
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
                      Text("매듭을 보냅니다!",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("매듭을 보내고 싶은 이웃의",
                        style: TextStyle(fontSize: 25,
                          color: Color(0xFFFF8D4D),
                          fontFamily: 'Noto Sans KR',
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 25, color: Color(0xFFFF8D4D), fontFamily: 'Noto Sans KR'),
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
                  )
              ),
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
        // 스캔 결과를 받은 후에는 다음 화면으로 네비게이션합니다.
        if (result != null) { //이 부분은 나중에 null일 경우 test 하면서 한 번 해봐야 할듯
          // 스캔 결과를 받은 후에 스캔을 일시 중지합니다.
          controller.pauseCamera();
          UserData().initializeData(jsonDecode(result!.code!)); //userdata로 결과 전송
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputTransform()),
          ).then((_) {
            controller.resumeCamera();
          });
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
