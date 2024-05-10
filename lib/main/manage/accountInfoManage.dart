import 'package:flutter/material.dart';
import '../../../utils/api/info/accountInfoPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userInfoManage.dart';

class AccountInfoMange{
  late String user_id;
  late String username ;
  late String mobile_number;
  late String password ;
  late String account_name;
  bool accountInfoUpdate = false;



  // 계좌 개인 정보
  void getAccountPriInfo({required username, required mobile_number, required password}){
    password = password;
    mobile_number = mobile_number;
    username = username;
  }

  // account 정보를 서버에 등록 할 때 사용
  fetchAccountData({required username, required mobile_number, required password}) async {
    UserInfoManage.setUserId();
    user_id = UserInfoManage.getUserId();
    getAccountPriInfo(username: username, mobile_number: mobile_number, password :password );

    try {
        final value = await accountInfoPost(password: password, username: username, mobile_number : mobile_number, user_id : user_id,  account_name : username);
      if (value["statusCode"] == 200) {
        print(value['message']);
        accountInfoUpdate = true;
      } else {
        print("account 서버 에러");
        print(value['message']);
        debugPrint('서버 에러입니다. 다시 시도해주세요');
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      //에러를 스트림을 통해 외부로 전달
      // _errorController.add(e.toString());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
    return accountInfoUpdate;
  }

}
