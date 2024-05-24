/*
userId를 이용한 통장 정보
 */

class ScannedUserAccountInfo {

  late String AccountId; //AccountId로 account 정보 가져오기
  late String AccountName; //통장 이름, 필요 없으면 사용자 이름으로
  late int Balance; //통장 잔액
  late bool blocked;
  late String blockedType; //blocked 계좌 여부..감이 안잡혀서 일단 이것만 가져옴

  // 싱글톤 인스턴스 생성
  static final ScannedUserAccountInfo _instance = ScannedUserAccountInfo._internal();

  factory ScannedUserAccountInfo() => _instance;

  // 내부 생성자
  ScannedUserAccountInfo._internal() {
    AccountId = '';
    AccountName = '';
    Balance = 0;
    blocked = false;
    blockedType = ''; //Enum class 같긴 한데..일단 이렇게 해두고 잘 받아오는지 test 필요
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    AccountId = _getStringValue(data, 'AccountId');
    AccountName = _getStringValue(data, 'AccountName');
    Balance = _getIntValue(data, 'Balance');
    blockedType = (blocked == false) ? this.blockedType = blockedType : '';
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }

  int _getIntValue(Map<String, dynamic> data, String key) {
    return int.parse(data[key]);
  }
}