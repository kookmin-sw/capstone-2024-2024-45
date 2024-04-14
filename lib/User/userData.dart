import 'dart:convert';

class UserData {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;
  late int amount;

  // 싱글톤 인스턴스 생성
  static final UserData _instance = UserData._internal();

  factory UserData() => _instance;

  // 내부 생성자
  UserData._internal() {
    id = '';
    email = '';
    firstName = '';
    lastName = '';
    avatar = '';
    amount = 0;
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    id = _getStringValue(data, 'id');
    email = _getStringValue(data, 'email');
    firstName = _getStringValue(data, 'first_name');
    lastName = _getStringValue(data, 'last_name');
    avatar = _getStringValue(data, 'avatar');
  }

  // 새로운 JSON 데이터 추가 메서드
  void addNewData(Map<String, dynamic> newData) {
    amount = newData['amount'] ?? 0; // amount 값이 없으면 기본값 0으로 설정
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }
}