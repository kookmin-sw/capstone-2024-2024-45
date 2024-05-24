import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // 구글 사용자 인지 확인
  if (googleUser == null) {
    throw Exception('Google 사용자가 아닙니다.');
  }

  print('Google 사용자가 맞습니다.');
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // accessToken, idToken 가져와서 firebase 인증 진행
  final oauthCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // Once signed in, return the UserCredential

  // FirebaseAuth로 사용자를 Custom Token으로 인증
  final userCredential = await FirebaseAuth.instance.signInWithCredential(
      oauthCredential);
  final user = userCredential.user;
  if (user != null) {
    String uid = user.uid;
    String? email = user.email;
    print("User UID: $uid");
    if (email != null) {
      print("User Email: $email");
    } else {
      print("User email is not available.");
    }
  }else {
    print('null');
  }
  // 이미 구글 로그인 정보가 있는 사용자 인지 아닌지
  // int userCheck = await isRegistered(user!.email!);
  // if(userCheck != 0){
  //   Get.to(HomeScreen());
  // }else{
  //   Get.to(SignupScreen());
  // }

  return userCredential;
  // }catch (e){
  //   print("Error signing in with custom token: $e");}
}

//
// Future<int> isRegistered(String email) async{
//   final response = await http.post(
//     Uri.parse('$baseUrl/user/email?email=$email'),
//   );
//   if (response.statusCode == 201 && response.body.length>0) {
//     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//     return jsonResponse['id'];
//   } else {
//     return 0;
//   }}