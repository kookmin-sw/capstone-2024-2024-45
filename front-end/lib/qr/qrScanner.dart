import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  TestAccountData testAccountData = TestAccountData();

  @override
  void initState() {
    super.initState();
    scannedUser = ScannedUser();
    dataUpdate = false;
    pushPopup = false;
  }

  Future<void> fetchData(String hmac, String data, String senderAccountId) async {
    //의문, 이미 앞단에서 한 번 가져와서 클래스에 저장하는데 또 요청을 해야하나?
    final String? token = await secureStorage.read(key: 'accessToken');
    if (token != null) {
      try {
        final value = await qrScanPost(hmac: hmac,
            data: data,
            senderAccountId: senderAccountId,
        token: token); //여기서 2가 id이다.
        if (value["statusCode"] == 200) { //서버 응답
          if (value["status"] == 200) { //검증 완료
            scannedUser.userInitializeData(value["data"]);
            setState(() {
              dataUpdate = true;
            });
          } else if (value["status"] == 400) { //유효기간 지난 코드

            setState(() {
              pushPopup = true;
            });
          }
        } else {
          ApiRequestFailAlert.showExpiredCodeDialog(context, qrScanner());
          debugPrint('서버 에러입니다. 다시 시도해주세요');
        }
      } catch (e) {
        ApiRequestFailAlert.showExpiredCodeDialog(context, qrScanner());
        debugPrint('API 요청 중 오류가 발생했습니다: $e');
      }
    }
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
            // URI 파싱

            int hmacIndex = str.indexOf("hmac=");
            String hmac = str.substring(hmacIndex + 5);
            hmac = hmac.split('&')[0];

            int dataIndex = str.indexOf("data=");
            String data = str.substring(dataIndex + 5);

            // print("=---------data!!!--------------");
            // print(data);
            // print(hmac);

            await fetchData(hmac,data, testAccountData.accountNumber);

            // print("=-------------------------------");
            // print(testAccountData.username);
            // print(testAccountData.accountId);

            // 차이가 2분 미만인지 확인
            if (dataUpdate) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InputTransfor()),
              ).then((_) {
                controller.resumeCamera();
              });
            } else if(pushPopup){
              // 2분 이상인 경우, alert dialog
              QrTimeOutDialog.showExpiredCodeDialog(context, () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                // 재스캔
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => qrScanner()),
                );
              });
            }
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
