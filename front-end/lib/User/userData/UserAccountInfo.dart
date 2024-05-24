/*
mainAccount에서 요청
 */

/**
 * pattern : api/accounts/{account_id} -> account_id는 accounts에서 얻을 것임
 */

class UserAccountInfo {
  late String accountId; //AccountId로 account 정보 가져오기
  late String userId;
  late String accountName; //통장 이름, 필요 없으면 사용자 이름으로
  late String name; //소유주 이름 //필요할지 미지수
  late String phoneNumber; //전화번호 //필요할지 미지수
  late int balance; //통장 잔액
  late bool blocked;
  late String blockedType; //blocked 계좌 여부..감이 안잡혀서 일단 이것만 가져옴

  // 싱글톤 인스턴스 생성
  static final UserAccountInfo _instance = UserAccountInfo._internal();

  factory UserAccountInfo() => _instance;

  // 내부 생성자
  UserAccountInfo._internal() {
    accountId = '';
    accountName = '';
    userId = '';
    name = '';
    phoneNumber = '';
    balance = 0;
    blocked = false;  // 초기화 추가
    blockedType = ''; // 초기화 추가
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    accountId = _getStringValue(data, 'AccountId');
    accountName = _getStringValue(data, 'AccountName');
    name = _getStringValue(data, '소유주본명');
    userId = _getStringValue(data, 'userId');
    balance = _getIntValue(data, 'Balance');
    phoneNumber = _getStringValue(data, '휴대폰번호');
    balance = _getIntValue(data, 'Balance');
    blockedType = (blocked == false) ? this.blockedType = blockedType : '';
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }

  int _getIntValue(Map<String, dynamic> data, String key) {
    return int.parse(data[key]);
  }
}