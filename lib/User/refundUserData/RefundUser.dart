
/*
{
  "transId": 1,
  "expectedAmount": "500",
  "inquire": "문의"
}

// inquire = 수정, 취소
 */

class RefundUser {
  late int transId;
  late String inquire;
  late String expectedAmount;

  // 싱글톤 인스턴스 생성
  static final RefundUser _instance = RefundUser._internal();

  factory RefundUser() => _instance;

  // 내부 생성자
  RefundUser._internal() {
    transId = 0;
    inquire = '';
    expectedAmount = '';
  }

  Map<String, dynamic> toJson() {
    return {
      'transId': transId,
      'inquire': inquire,
      'expectedAmount': expectedAmount,
    };
  }
}