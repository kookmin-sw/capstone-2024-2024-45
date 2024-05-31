import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:suntown/utils/api/connect/loginAuthPost.dart';

Future<bool> signInWithGoogle() async {

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // 구글 사용자 인지 확인
  if (googleUser == null) {
    throw Exception('Google 사용자가 아닙니다.');
  }

  print('Google 사용자가 맞습니다.');
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // 서버로 accesstoken 보내기
  try {
    final value = await loginAuthPost(token: googleAuth.accessToken!);
    if (value["statusCode"] == 200) {
      print('login 서버에 무사히 접속');
      print(value);
      return true;
    } else if (value["statusCode"] == 400) {
      print(value);
      debugPrint('loginAuthPost서버 에러입니다. 다시 시도해주세요');
    } else {
      print(value);
      debugPrint('loginAuthPost서버 에러입니다. 다시 시도해주세요');
      print(value['message']);
      throw Exception('서버 에러입니다. 다시 시도해주세요');
    }
  } catch (e) {
    print('fetchKakaoToken 에러------------');
    print(e);
  }

  return false;
  // // accessToken, idToken 가져와서 firebase 인증 진행
  // final oauthCredential = GoogleAuthProvider.credential(
  //   accessToken: googleAuth.accessToken,
  //   idToken: googleAuth.idToken,
  // );

  // final userCredential = await FirebaseAuth.instance.signInWithCredential(
  //     oauthCredential);
  // final user = userCredential.user;
  // if (user != null) {
  //   String uid = user.uid;
  //   String? email = user.email;
  //   print("User UID: $uid");
  //   if (email != null) {
  //     print("User Email: $email");
  //   } else {
  //     print("User email is not available.");
  //   }
  // }else {
  //   print('null');
  // }


}
