
class ScannerUser {
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;
  late String dateTime;

  // 싱글톤 인스턴스 생성
  static final ScannerUser _instance = ScannerUser._internal();

  factory ScannerUser() => _instance;

  // 내부 생성자
  ScannerUser._internal() {
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