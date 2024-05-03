/*
송금 api로 보내기 위함
 */
class SendApi {
  late String sendAccountId;
  late String receiverAccountId;
  late int amount;

  // 싱글톤 인스턴스 생성
  static final SendApi _instance = SendApi._internal();

  factory SendApi() => _instance;

  // 내부 생성자 (임시)
  SendApi._internal() {
    sendAccountId = '김철수'; //로그인 세션에서 받아올 예정
    receiverAccountId = ''; //Scanner에서 받아온  데이터 사용
    amount = 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'sendAccountId': sendAccountId,
      'receiveAccountId': receiverAccountId,
      'amount': amount,
    };
  }
}

// import 'dart:ffi';
//
// class SendApi {
//   late String sendAccountId;
//   late String receiverAccountId;
//   late int amount;
//
//   // 싱글톤 인스턴스 생성
//   static final SendApi _instance = SendApi._internal();
//
//   factory SendApi() => _instance;
//
//   //생성자
//   SendApi._internal() {
//     sendAccountId = '';
//     receiverAccountId = '';
//     amount = 0;
//   }
//
//   // API 데이터 초기화 메서드
//   void initializeData(Map<String, dynamic> data) {
//     sendAccountId = _getStringValue(data, 'id');
//     receiverAccountId = _getStringValue(data, 'email');
//     amount = _getIntValue(data, 'first_name');
//   }
//
//   String _getStringValue(Map<String, dynamic> data, String key) {
//     return data[key].toString();
//   }
//
//   int _getIntValue(Map<String, dynamic> data, String key) {
//     return int.parse(data[key]);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'sendAccountId': sendAccountId,
//       'receiverAccountId': receiverAccountId,
//       'amount': amount,
//     };
//   }
// }