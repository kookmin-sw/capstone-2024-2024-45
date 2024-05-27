/*
"data": {
    "nickName": "얌얌",
    "accountNumber": "293202537103",
    "totalBudget": 600,
    "availableBudget": 600,
    "isBlocked": false
  }
 */

class TestAccountData {
  late String nickName; //유저 이름이자 계좌 이름
  late String accountNumber;
  late int totalBudget;
  late int availableBudget;
  late bool isBlocked;
  late String userId;

  // 싱글톤 인스턴스 생성
  static final TestAccountData _instance = TestAccountData._internal();
  factory TestAccountData() => _instance;

  // 내부 생성자
  TestAccountData._internal() {
    nickName = '';
    accountNumber = '';
    totalBudget = 0;
    availableBudget = 0;
    userId = '';
    isBlocked = false;
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    nickName = _getStringValue(data, 'nickName');
    accountNumber = _getStringValue(data, 'accountNumber');
    totalBudget = _getIntValue(data, 'totalBudget');
    availableBudget = _getIntValue(data, 'availableBudget');
    isBlocked = _getBoolValue(data, 'isBlocked');
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }

  int _getIntValue(Map<String, dynamic> data, String key) {
    return data[key];
  }

  bool _getBoolValue(Map<String, dynamic> data, String key) {
    return data[key];
  }
}