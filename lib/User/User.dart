/*
로그인 세션을 통새 자신의 정보를 얻어옴
 */
class User {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;
  late int amount;

  // 싱글톤 인스턴스 생성
  static final User _instance = User._internal();

  factory User() => _instance;

  // 내부 생성자
  User._internal() {
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

// class User {
//
//   late String AccountId; //이걸 list로 잡아야 하나...고민중
//   late String Name; //이름값
//   late String Profile; //프로필 사진
//   late int amount;
//
//   // 싱글톤 인스턴스 생성
//   static final User _instance = User._internal();
//
//   factory User() => _instance;
//
//   // 내부 생성자
//   User._internal() {
//     AccountId = '';
//     Name = '';
//     Profile = '';
//   }
//
//   // API 데이터 초기화 메서드
//   void initializeData(Map<String, dynamic> data) {
//     AccountId = _getStringValue(data, 'AccountId');
//     Name = _getStringValue(data, 'Name');
//     Profile = _getStringValue(data, 'Profile');
//   }
//
//   // 새로운 JSON 데이터 추가 메서드
//   void addNewData(Map<String, dynamic> newData) {
//     amount = newData['amount'] ?? 0; // amount 값이 없으면 기본값 0으로 설정
//   }
//
//   String _getStringValue(Map<String, dynamic> data, String key) {
//     return data[key].toString();
//   }
// }