import 'package:flutter/material.dart';
import "package:suntown/utils/api/info/userInfoPost.dart";
import 'package:firebase_auth/firebase_auth.dart';


class UserInfoRegister{
  String userId = '';
  String? email = '' ;
  String? nickName = '';
  String? image_url = '' ;
  String name = '';
  String mobile_number = '';
  bool userInfoUpdate = false;

  // 현재 사용자 정보를 firebase에서 가져옴.
  void getUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      email = user.email;
      nickName = user.displayName;
      image_url = user.photoURL;
      print('User ID: ${userId}');
      print('User Email: ${email}');
      print('User Display Name: ${nickName}');
      print('User Photo URL: ${image_url}');
    } else {
      print('No user is currently signed in.');
    }
  }

  void getUserPriInfo({required name, required mobile_number}){
    name = name;
    mobile_number = mobile_number;
  }

  // user 정보를 서버에 등록 할 때 사용.(회원가입 계좌 정도 저장)
  fetchUserData({required name, required mobile_number}) async {
    getUserInfo();
    getUserPriInfo(name: name, mobile_number: mobile_number);

    try {
      final value = await userInfoPost( oauth_id: userId, mobile_number: mobile_number, name : name,nickname : nickName,  image_url : image_url); //여기서 2가 id이다.
      if (value["statusCode"] == 200) {
        userInfoUpdate = true;
      } else {
        print("user info 에러");
        debugPrint('서버 에러입니다. 다시 시도해주세요');
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      //에러를 스트림을 통해 외부로 전달
      // _errorController.add(e.toString());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
    return userInfoUpdate;
  }

}
