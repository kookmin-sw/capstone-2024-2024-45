
/*
송금 디테일 정보
 */

import 'package:intl/intl.dart';

class listDetailUser {
  late String senderNickname;
  late String senderProfileImg;
  late int senderBalanceAfter;

  late String receiverNickname;
  late String receiverProfileImg;
  late int receiverBalanceAfter;
  late String createdAt;

  late String formattedSenderBalanceAfter;
  late String formattedReceiverBalanceAfter;

  late String formattedAmount;

  late bool sender;
  late int amount;

  // 싱글톤 인스턴스 생성
  static final listDetailUser _instance = listDetailUser._internal();

  factory listDetailUser() => _instance;

  // 내부 생성자
  listDetailUser._internal() {
    senderNickname = '';
    senderProfileImg = '';
    senderBalanceAfter = 0;

    formattedSenderBalanceAfter = '';

    receiverNickname = '';
    receiverProfileImg = '';
    receiverBalanceAfter = 0;

    formattedReceiverBalanceAfter = '';

    createdAt = '';
    sender = false;

    amount = 0;

    formattedAmount = '';
  }

  // user에서 얻을 정보
  void userInitializeData(Map<String, dynamic> data) {
    senderNickname = _getStringValue(data, 'senderNickname');
    senderProfileImg = _getStringValue(data, 'senderProfileImg');

    senderBalanceAfter = data['senderBalanceAfter'];

    formattedSenderBalanceAfter = _getNumberFormatter(senderBalanceAfter);

    receiverNickname = _getStringValue(data, 'receiverNickname');
    receiverProfileImg = _getStringValue(data, 'receiverProfileImg');
    receiverBalanceAfter = data['receiverBalanceAfter'];

    formattedReceiverBalanceAfter = _getNumberFormatter(receiverBalanceAfter);

    createdAt = _getTimeValue(data, 'createdAt');
    sender = data['sender'];
    amount = data['amount'];

    formattedAmount = _getNumberFormatter(amount);
  }



  String _getTimeValue(Map<String, dynamic> data, String key){
    DateTime dateTime = DateTime.parse(data[key] ?? ''.toString());
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    String formattedDateTime = formatter.format(dateTime);
    return formattedDateTime;
  }

  String _getStringValue(Map<String, dynamic> data, String key) {
    return data[key] ?? ''.toString();
  }

  String _getNumberFormatter(int amount){
    NumberFormat f = NumberFormat("#,###");
    return f.format(amount);
  }
}