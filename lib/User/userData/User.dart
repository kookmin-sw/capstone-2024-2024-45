/*
사용자 정보를 얻어옴
    "userId": 0,
    "nickName": "string",
    "gender": "male",
    "address": "string",
    "ageRange": 20,
    "birth": "string",
    "accountNumber": "string",
    "profileImage": "string",
    "blocked": true,
    "dealCount": 0
 */
class User {
  late String userId;
  late String nickName;
  late String gender;
  late String address;
  late String ageRange;
  late String birth;
  late String accountNumber;
  late String profileImage;

  // 싱글톤 인스턴스 생성
  static final User _instance = User._internal();

  factory User() => _instance;

  // 내부 생성자
  User._internal() {
    userId = '';
    nickName = '';
    gender = '';
    address = '';
    ageRange = '';
    birth = '';
    accountNumber = '';
    profileImage = '';
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    userId = _getStringValue(data, 'userId');
    nickName = _getStringValue(data, 'nickName');
    gender = _getStringValue(data, 'gender');
    address = _getStringValue(data, 'address');
    ageRange = _getStringValue(data, 'ageRange');
    birth = _getStringValue(data, 'birth');
    accountNumber = _getStringValue(data, 'accountNumber');
    profileImage = _getStringValue(data, 'profileImage');
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }
}
