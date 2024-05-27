/*
상태관리 클래스를 따로 나눔
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/utils/api/info/qrPost.dart';

import '../User/scannedUserData/SecretScannedUserData.dart';
import '../User/test/testAccountData.dart';
import '../User/userData/User.dart';
import '../main/alert/apiFail/ApiRequestFailAlert.dart';

class QrScreenProvider extends ChangeNotifier {
  late DateTime expirationTime;
  late Timer timer;
  bool expired = false;
  late SecretScannedUserData secretScannedUserData;
  bool dataupdate = false;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  TestAccountData testAccountData = TestAccountData();

  QrScreenProvider() {
    _init();
  }

  void _init() async {
    expirationTime = DateTime.now().add(Duration(minutes: 1, seconds: 30));
    secretScannedUserData = SecretScannedUserData();
    fetchData(testAccountData.accountNumber, testAccountData.userId);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimer();
    });
  }



  //qr에 담을 암호화 정보를 위함
  Future<void> fetchData(String accountId, String userId) async {
    //의문, 이미 앞단에서 한 번 가져와서 클래스에 저장하는데 또 요청을 해야하나?
    final String? token = await secureStorage.read(key: 'accessToken');
    if (token != null) {
      try {
        final value = await qrPost(token, accountId, userId); //여기서 2가 id이다.
        if (value["statusCode"] == 200) {
          secretScannedUserData.initializeData(value['data']);
          print("=------------qr 데이터 ---------------");
          print("hmac = " + secretScannedUserData.hmac);
          print("incodingData = " + secretScannedUserData.incodingData);

          dataupdate = true; //update가 된 뒤에 view가 나오도록 정의!
        } else {
          debugPrint('서버 에러입니다. 다시 시도해주세요');
          throw Exception('서버 에러입니다. 다시 시도해주세요');
        }
      } catch (e) {
        //에러를 스트림을 통해 외부로 전달
        _errorController.add(e.toString());
        debugPrint('API 요청 중 오류가 발생했습니다: $e');
      }
    }
  }
  void _updateTimer() {
    if (expirationTime.isAfter(DateTime.now())) {
      expired = true;
    } else {
      expired = false;
    }
    notifyListeners(); // 상태가 변경되었음을 알립니다.
  }

  void refreshQrData() {
    expirationTime = DateTime.now().add(Duration(minutes: 1, seconds: 30));
    fetchData(testAccountData.accountNumber, testAccountData.userId);
    if(dataupdate){ //데이터 업데이트가 된 후에 다시 업데이트
      expired = false;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _updateTimer();
      });
      notifyListeners();
    };
    dataupdate = false;
  }

  // 에러를 외부로 전달할 스트림
  final _errorController = StreamController<String>.broadcast();
  Stream<String> get errorStream => _errorController.stream;

  void dispose() {
    _errorController.close();
    super.dispose();
  }
}