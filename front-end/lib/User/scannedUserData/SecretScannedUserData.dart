/*
암호화된 정보
 */

class SecretScannedUserData {
  late String incodingData;
  late String hmac;

  // 싱글톤 인스턴스 생성
  static final SecretScannedUserData _instance = SecretScannedUserData._internal();

  factory SecretScannedUserData() => _instance;

  // 내부 생성자
  SecretScannedUserData._internal() {
    incodingData = '';
    hmac = '';
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    incodingData = _getStringValue(data, 'userInfo');
    hmac = _getStringValue(data, 'hmac');
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }
}