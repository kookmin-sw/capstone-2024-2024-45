import 'dart:convert';

class SendApi {
  late String sendAccountId;
  late String receiveAccountId;
  late int amount;

  // 싱글톤 인스턴스 생성
  static final SendApi _instance = SendApi._internal();

  factory SendApi() => _instance;

  // 내부 생성자 (임시)
  SendApi._internal() {
    sendAccountId = '김철수'; //로그인 세션에서 받아올 예정
    receiveAccountId = ''; //api에서 받아오기
    amount = 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'sendAccountId': sendAccountId,
      'receiveAccountId': receiveAccountId,
      'amount': amount,
    };
  }
}