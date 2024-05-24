/*
"user_id": "155d5adc0512476c957722d8d22a48c2",
    "role": "User",
    "gender": "female",
    "name": "jieun",
    "oauth_id": "o5MsRMbmmBT0QhuYTofxmSvvs6t1",
    "mobile_number": "010-1234-5678",
    "create_at": "2024-05-09"
 */

class UserF {
  late String user_id;
  late String role;
  late String gender;
  late String name;
  late String oauth_id;
  late String mobile_number;
  late String profile;

  // 싱글톤 인스턴스 생성
  static final UserF _instance = UserF._internal();

  factory UserF() => _instance;

  // 내부 생성자
  UserF._internal() {
    user_id = '';
    role = '';
    gender = '';
    name = '';
    oauth_id = '';
    mobile_number = '';
    profile = '';
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    user_id = _getStringValue(data, 'user_id');
    role = _getStringValue(data, 'role');
    gender = _getStringValue(data, 'gender');
    name = _getStringValue(data, 'name');
    oauth_id = _getStringValue(data, 'oauth_id');
    mobile_number = _getStringValue(data, 'mobile_number');
    profile = _getStringValue(data, 'profile');
  }


  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }
}
