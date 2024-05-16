import 'package:flutter/cupertino.dart';

import '../../User/scannedUserData/ScannedUser.dart';
import '../../User/test/testAccountData.dart';
import '../../main/alert/apiFail/ApiRequestFailAlert.dart';
import '../api/test/testMainAccountDetailGet.dart';
import '../api/test/testMainAccountGet.dart';

class AccountService {
  String testUserId = "7bc63565df6747e5986172da311d37ab"; //김국민
  TestAccountData testAccountData = TestAccountData();

  List<String> userAccountIds = []; //account 정보를 담아옴

  Future<void> fetchAccountListData(String userId, Function(bool) accountDataLoadCallback) async {
    try {
      final Map<String, dynamic> response = await testMainAccountGet(userId);
      if (response['statusCode'] == 200) {
        for (var i = 0; i < response['data'].length; i++) {
          userAccountIds.add(response['data'][i]);
          await fetchAccountData(userAccountIds[0], (success) {
            if (success) {
              // 작업이 성공했을 때의 처리
              accountDataLoadCallback(true);
            } else {
              // 작업이 실패했을 때의 처리
              accountDataLoadCallback(false);
            }
          });
          print("--------------UserId-------------");
          print(userId);
          print("--------------accountId-------------");
          print(userAccountIds[0]);
        }
      } else {
        // Handle error
        print('Error: ${response['statusCode']}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<void> fetchAccountData(String accountId, Function(bool) callback) async {
    try {
      final Map<String, dynamic> response =
          await testMainAccountDetailGet(accountId);

      if (response["statusCode"] == 200) {
        testAccountData.initializeData(response["result"]);
        callback(true);
      } else {
        callback(false);
        // ApiRequestFailAlert.showExpiredCodeDialog(context, qrScanner());
        debugPrint('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      callback(false);
      // ApiRequestFailAlert.showExpiredCodeDialog(context, qrScanner());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }
}
