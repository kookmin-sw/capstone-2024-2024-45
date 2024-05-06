/*
이거 삭제해도 될듯.,..?
순서 정확히 맞춰보고 삭제하기
 */

class User {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;
  late String dateTime;
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
    dateTime = '';
  }

  // // 새로운 JSON 데이터 추가 메서드
  // void addNewData(Map<String, dynamic> newData) {
  //   amount = newData['amount'] ?? 0; // amount 값이 없으면 기본값 0으로 설정
  // }

  // 새로운 JSON 데이터 추가 메서드
  void addNewData(DateTime now) {
    dateTime = now.toString() ?? ''; // amount 값이 없으면 기본값 0으로 설정
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }
}

/*
갈아 끼울 부분
 */

/**
 * userId 추가하기
 */

// class User {
//
//   late String deviceId; //구분자로 사용할 부분.
//   late String name; //이름값
//   late String profile; //프로필 사진, user 정보에 추가 필요!
//   late String phoneNumber;
//   late String userId; //user_id 로직상 필요할 것 같아서 추가
//
//   // 싱글톤 인스턴스 생성
//   static final User _instance = User._internal();
//
//   factory User() => _instance;
//
//   // 내부 생성자
//   User._internal() {
//     deviceId = '';
//     name = '';
//     profile = ''; //api user 정보에서 프로필 정보 필요!
//     phoneNumber = '';
//     userId = '';
//   }
//
//   // API 데이터 초기화 메서드
//   void initializeData(Map<String, dynamic> data) {
//     deviceId = _getStringValue(data, 'device_Id');
//     name = _getStringValue(data, 'name');
//     profile = _getStringValue(data, 'profile');
//
//     phoneNumber = _getStringValue(data, 'mobile_number');
//     // userId = _getStringValue(data, 'profile');
//   }
//
//   // // 새로운 JSON 데이터 추가 메서드
//   // void addNewData(Map<String, dynamic> newData) {
//   //   userId = newData['userId'] ?? 0; // amount 값이 없으면 기본값 0으로 설정
//   // }
//   //여기서 userId 얻어와야 하는데 이건 좀 고민해보기.
//
//   String _getStringValue(Map<String, dynamic> data, String key) {
//     return data[key].toString();
//   }
// }