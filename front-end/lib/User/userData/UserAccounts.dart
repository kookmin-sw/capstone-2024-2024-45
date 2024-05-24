

import 'User.dart';
import 'UserAccountInfo.dart';

/**
 * api/user/{user_id}/accounts 를 통해 조회한 전체 계좌 결과를 저장
 */

class UserAccounts {
  // 싱글톤 인스턴스 생성
  static final UserAccounts _instance = UserAccounts._internal();
  factory UserAccounts() => _instance;

  List<User> users = [];

  UserAccounts._internal();

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    //'accounts' 부분은 accountslist 담긴 부분(예상)
    List<UserAccountInfo> userAccounts = (data['accounts'] as List<dynamic>).map((accountData) {
      var userAccountInfo = UserAccountInfo();
      userAccountInfo.initializeData(accountData);
      return userAccountInfo;
    }).toList();
  }
}