/*
상태관리 클래스를 따로 나눔
 */

import 'dart:async';
import 'package:flutter/material.dart';

import '../User/User.dart';

class QrScreenProvider extends ChangeNotifier {
  late DateTime expirationTime;
  late Timer timer;
  bool expired = false;
  late User user;
  bool dataupdate = false;

  QrScreenProvider() {
    _init();
  }

  void _init() async {
    expirationTime = DateTime.now().add(Duration(minutes: 2));
    user = User();
    fetchData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimer();
    });
  }

  // Future<void> fetchData() async { //의문, 이미 앞단에서 한 번 가져와서 클래스에 저장하는데 또 요청을 해야하나?
  //   try {
  //     final value = await httpGet(path: '/api/users/2'); //여기서 2가 id이다.
  //     if (value["statusCode"] == 200) {
  //       scannerUser.initializeData(value['data']);
  //       scannerUser.addNewData(expirationTime);
  //
  //       dataupdate = true; //update가 된 뒤에 view가 나오도록 정의!
  //     } else {
  //       debugPrint('서버 에러입니다. 다시 시도해주세요');
  //     }
  //   } catch (e) {
  //     debugPrint('API 요청 중 오류가 발생했습니다: $e');
  //   }
  // }

  //이미 메인 화면에서 user 정보를 가져왔기 때문에, 그대로 사용
  void fetchData() async { //의문, 이미 앞단에서 한 번 가져와서 클래스에 저장하는데 또 요청을 해야하나?
    user.addNewData(expirationTime);

    dataupdate = true; //update가 된 뒤에 view가 나오도록 정의!
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
    if(dataupdate){ //데이터 업데이트가 된 후에 다시 업데이트
      expired = false;
      expirationTime = DateTime.now().add(Duration(minutes: 2));
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _updateTimer();
      });
      notifyListeners();
    };
  }
}