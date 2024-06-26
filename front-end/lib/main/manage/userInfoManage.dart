import 'package:flutter/material.dart';
import "package:suntown/utils/api/info/userInfoPost.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:suntown/utils/api/info/oauthIdGet.dart";
import "package:suntown/utils/api/info/userInfoGet.dart";


class UserInfoManage{
  static late String _oauth_id; // firebase에서 가져오는 uid
  static String? _user_id ; // 우리 서버에 저장되어 있는 user_id
  late String? email ;
  late String? nickName ;
  late String? image_url ;
  late String name ;
  late String mobile_number;

  bool userInfoUpdate = false;

  // _oauth_id를 가져오는 정적 메서드를 추가합니다.
  static String getOauthId() {
    setOauthId();
    return _oauth_id;
  }

  // _oauth_id를 설정하는 정적 메서드를 추가합니다.
  static void setOauthId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _oauth_id = user.uid;
    }
  }

  // userID가 초기화 될때 까지 기다렸다가 _user_id를 return
  Future<String?> getUserId() async {
    await setUserIdIfNeeded();
    return _user_id ?? "";
  }

  // _user_id로 서버에 요청을 보내 user_id를 얻어옴.
  static Future<void> setUserId() async {
    try {
      setOauthId();
      final value_userID = await oauthIdGet(oauth_id: _oauth_id);
      if (value_userID["statusCode"] == 200) {
        _user_id = value_userID['result']['user_id'];
      } else {
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      throw Exception('API 요청 중 오류가 발생했습니다: $e');
    }
  }

  static Future<void> setUserIdIfNeeded() async {
    if (_user_id == null) {
      await setUserId();
    }
  }

  // _user_id로 user정보 가져옴.
  getUserInfo() async {
    try{
      await setUserIdIfNeeded(); // _user_id가 초기화되었는지 확인
      if (_user_id != null) {
        print("------if문 진입-------");
        final value_userInfo = await userInfoGet(user_id: _user_id!);
        print('value_userInfo : $value_userInfo');
        if (value_userInfo["statusCode"] == 200){
          print('user info get 200');
          print(value_userInfo['message']);
          return value_userInfo;
          // return // user info return
        } else {
          debugPrint("getUserInfo 서버 에러");
          print(value_userInfo['message']);
          throw Exception('서버 에러입니다. 다시 시도해주세요');
        }
      } else {
        debugPrint("getUserInfo _user_id == null 에러");
        throw Exception('_user_id가 초기화되지 않았습니다.');
      }
    } catch (e){
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }

  // 현재 사용자 정보를 firebase에서 가져옴.
  void getUserInfoFirebase() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email;
      nickName = user.displayName;
      image_url = user.photoURL;

      print('User ID: ${_oauth_id}');
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

  // user 정보를 서버에 등록 할 때 사용.(회원가입 계좌 정보 저장)
  fetchUserData({required name, required mobile_number}) async {
    setOauthId();
    getUserInfoFirebase();
    getUserPriInfo(name: name, mobile_number: mobile_number);

    try {
      final value = await userInfoPost( oauth_id: _oauth_id, mobile_number: mobile_number, name : name, nickname : nickName,  image_url : image_url);
      if (value["statusCode"] == 200) {
        print(value['message']);
        userInfoUpdate = true;
      } else if(value["statusCode"] == 400){
        // 따로 처리 필요
        print('이미 존재하는 유저');
      }else {
        print("fetchUserData 에러");
        print(value['message']);
        debugPrint('서버 에러입니다. 다시 시도해주세요');
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
    return userInfoUpdate;
  }

}
