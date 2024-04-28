class ScannedUser {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;
  late String dateTime;

  // 싱글톤 인스턴스 생성
  static final ScannedUser _instance = ScannedUser._internal();

  factory ScannedUser() => _instance;

  // 내부 생성자
  ScannedUser._internal() {
    id = '';
    email = '';
    firstName = '';
    lastName = '';
    avatar = '';
    dateTime = '';
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
  void addNewData(DateTime now) {
    dateTime = now.toString() ?? ''; // amount 값이 없으면 기본값 0으로 설정
  }
  // toJson 메서드 구현
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'dateTime': dateTime,
    };
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }
}

/*
user로 교체할때 사용
blocked값도 추가해야함.
 */

// class ScannerUser {
//   late String AccountId;
//   late String Name; //이름값
//   late String Profile; //프로필 사진
//   late String dateTime;
//
//   // 싱글톤 인스턴스 생성
//   static final ScannerUser _instance = ScannerUser._internal();
//
//   factory ScannerUser() => _instance;
//
//   // 내부 생성자
//   ScannerUser._internal() {
//     AccountId = '';
//     Name = '';
//     Profile = '';
//     dateTime = '';
//   }
//
//   // API 데이터 초기화 메서드
//   void initializeData(Map<String, dynamic> data) {
//     AccountId = _getStringValue(data, 'AccountId');
//     Name = _getStringValue(data, 'Name');
//     Profile = _getStringValue(data, 'Profile');
//   }
//
//   // 새로운 JSON 데이터 추가 메서드, 여기서는 scan을 통해 dataTime을 가져오기 위함
//   void addNewData(DateTime now) {
//     dateTime = now.toString() ?? ''; // amount 값이 없으면 기본값 0으로 설정
//   }
//   // toJson 메서드 구현
//   Map<String, dynamic> toJson() {
//     return {
//       'AccountId': AccountId,
//       'Name': Name,
//       'Profile': Profile,
//       'dateTime': dateTime,
//     };
//   }
//
//   String _getStringValue(Map<String, dynamic> data, String key) {
//     return data[key].toString();
//   }
// }