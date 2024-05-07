import 'package:flutter/material.dart';
import '../../../utils/api/info/accountInfoPost.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AccountInfoRegister{
  String user_id = '';
  String username = '';
  String mobile_number = '';
  String password = "";
  String account_name ="";
  bool accountInfoUpdate = false;


  // 현재 사용자 정보를 firebase에서 가져옴.
  void getUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user_id = user.uid;
      print('User ID: ${user_id}');
    } else {
      print('No user is currently signed in.');
    }
  }

  // 계좌 개인 정보
  void getAccountPriInfo({required username, required mobile_number, required password}){
    password = password;
    mobile_number = mobile_number;
    username = username;
  }

  // account 정보를 서버에 등록 할 때 사용
  fetchAccountData({required username, required mobile_number, required password}) async {
    getUserInfo();
    getAccountPriInfo(username: username, mobile_number: mobile_number, password :password );

    try {
        final value = await accountInfoPost(password: password, username: username, mobile_number : mobile_number, user_id : user_id,  account_name : username);
      if (value["statusCode"] == 200) {
        accountInfoUpdate = true;
      } else {
        print("account 서버 에러");
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
