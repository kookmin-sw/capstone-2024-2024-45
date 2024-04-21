/*
상태관리 클래스를 따로 나눔
 */

import 'dart:async';
import 'package:flutter/material.dart';

import '../../User/ScannerUser.dart';
import '../../utils/http_request.dart';

class QrScreenProvider extends ChangeNotifier {
  late DateTime expirationTime;
  late Timer timer;
  bool expired = false;
  late ScannerUser scannerUser;
  bool dataupdate = false;

  QrScreenProvider() {
    _init();
  }

  void _init() async {
    expirationTime = DateTime.now().add(Duration(minutes: 1));
    scannerUser = ScannerUser();
    await fetchData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimer();
    });
  }

  Future<void> fetchData() async {
    try {
      final value = await httpGet(path: '/api/users/2'); //여기서 2가 id이다.
      if (value["statusCode"] == 200) {
        scannerUser.initializeData(value['data']);
        scannerUser.addNewData(expirationTime);

        dataupdate = true; //update가 된 뒤에 view가 나오도록 정의!
      } else {
        debugPrint('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
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
    fetchData().then((_) { //동기화를 통해 qr이 따로노는 문제 해결 완료
      expired = false;
      expirationTime = DateTime.now().add(Duration(minutes: 1));
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _updateTimer();
      });
      notifyListeners();
    });
  }
}