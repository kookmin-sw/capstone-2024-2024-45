/* {
  "type": "User",
  "password": "string",
  "username": "string",
  "mobile_number": "string",
  "user_id": "string",
  "account_name": "string"
} */

import 'package:flutter/material.dart';
import '../../../utils/api/info/accountInfoPost.dart';
import 'userInfoManage.dart';
import '../../../utils/api/connect/userAccoPost.dart';
import '../../../utils/api/info/accountIdGet.dart';

class AccountInfoMange{
  static late String account_id;
  late String password;
  late String username ;
  late String mobile_number;
  late String user_id ;
  late String account_name;
  bool accountInfoUpdate = false;

  // account_id 가져오는 정적 메서드
  static String getAccount_id()  {
    return account_id;
  }

  // account_id 설정하는 정적 메서드
  static void setAccount_id({required user_id}) async {
    try {
      final value = await accountIdGet(user_id: user_id);
      print("setaccount_id 성공");
      print(value);
      if (value["statusCode"] == 200) {
        print(value['result']['account_id_list'][0]);
        account_id =  value['result']['account_id_list'][0];
      } else {
        debugPrint("setaccount_id 서버 에러");
        print(value['message']);
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
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
    UserInfoManage.setUserId();
    user_id = UserInfoManage.getUserId();
    getAccountPriInfo(username: username, mobile_number: mobile_number, password :password );

    try {
        final value = await accountInfoPost(password: password, username: username, mobile_number : mobile_number, user_id : user_id,  account_name : username);
      if (value["statusCode"] == 200) {
        print("accountInfoPost 여기까지는 성공");
        print(value['message']);
        accountInfoUpdate = true;
        account_id = value['result']['account_id'];
        // account id와 성공 여부를 return
        return {
          "accountInfoUpdate" : accountInfoUpdate,
          "account_id" : value['result']['account_id'] // 계좌개설 후 account_id값을 return 해줌.
        };
      } else {
        print('account 서버 에러"');
        debugPrint("account 서버 에러");
        print(value['message']);
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
    // account id와 성공 여부를 return
    return {
      "accountInfoUpdate" : accountInfoUpdate,
      "account_id" : ""
    };
  }

  // 처음 계좌 개설 할 때, account 정보와 user 정보를 매핑 할 때 사용.
connectUserAccount({required username}) async {
  user_id = UserInfoManage.getUserId();
  setAccount_id(user_id:user_id);

    try{
      final value = await userAccoPost(user_id: user_id, account_id : account_id, name: username);
      if (value['statusCode']==200){
        print("connectUserAccount 여기까지는 성공");
        print(value['message']);
        return true;
      }else{
        print("connectUserAccount 실패");
        debugPrint("connectUserAccount 서버 에러");
        print(value['message']);
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    }catch (e){
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
    return false;
}


}
