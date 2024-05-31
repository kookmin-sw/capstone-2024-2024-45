/*
qr에서 스캔해올 정보
 */

class ScannedUser {
  late String accountId; //accountId
  late String name; //이름값
  late String profile; //프로필 사진
  late String senderBalance;

  // 싱글톤 인스턴스 생성
  static final ScannedUser _instance = ScannedUser._internal();

  factory ScannedUser() => _instance;

  // 내부 생성자
  ScannedUser._internal() {
    accountId = '';
    name = '';
    profile = ''; //임시..
    senderBalance = ''; //임시
  }

  // user에서 얻을 정보
  void userInitializeData(Map<String, dynamic> data) {
    name = _getStringValue(data, 'receiverNickname');
    profile = _getStringValue(data, 'receiverProfileImg');
    accountId =_getStringValue(data, 'receiverAccountId');
    senderBalance =_getStringValue(data, 'senderBalance');
  }

  // toJson 메서드 구현
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'name': name,
      'profile': profile,
    };
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }

  int _getIntValue(Map<String, dynamic> data, String key) {
    return int.parse(data[key]);
  }
}