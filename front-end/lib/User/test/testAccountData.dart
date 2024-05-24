
/*
{
  "is_success": true,
  "status_code": 200,
  "message": "계좌 조회에 성공하였습니다",
  "result": {
  "balance": 300,
  "username": "testuser",
  "type": "User",
  "created_at": "2024-05-06",
  "account_name": "testaccount",
  "suspend_type": null,
  "password": "testpassword",
  "account_id": "3f10f03bec6149dfb0e9770f56edd4c6",
  "mobile_number": "010-1234-5678",
  "user_id": "7bc63565df6747e5986172da311d37ab",
  "is_suspended": false
  }
}
*/

//이거 바꿔야 한다.
//일단은...단일 계좌니까 이렇게 진행해도 괜찮을 것 같음

//account block 타입 없음!
class TestAccountData {
  late String accountName;

  late String username; //필요할지 몰라서 일단 킵
  late String accountId; //필요할지 몰라서 일단 킵
  late String userId; //필요할지 몰라서 일단 킵
  late int balance;

  // 싱글톤 인스턴스 생성
  static final TestAccountData _instance = TestAccountData._internal();
  factory TestAccountData() => _instance;

  // 내부 생성자
  TestAccountData._internal() {
    accountName = '';
    username = '';
    accountId = '';
    userId = '';
    balance = 0;
  }

  // API 데이터 초기화 메서드
  void initializeData(Map<String, dynamic> data) {
    accountName = _getStringValue(data, 'account_name');
    username = _getStringValue(data, 'username');
    accountId = _getStringValue(data, 'account_id');
    userId = _getStringValue(data, 'user_id');
    balance = _getIntValue(data, 'balance');
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key].toString();
  }

  int _getIntValue(Map<String, dynamic> data, String key) {
    return data[key];
  }
}