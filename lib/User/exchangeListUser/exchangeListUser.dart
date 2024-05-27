
import 'package:intl/intl.dart';

class exchangeListUser {
  late int transId;
  late bool send;
  late String senderNickname;
  late String receiverNickname;
  late String senderProfileImg;
  late String receiverProfileImg;
  late int postBalance;
  late int amount;
  late String createdAt;
  late String createdAtToDaily; //list를 위한 값 저장 완료

  exchangeListUser({required this.transId, required this.amount, required this.senderNickname, required this.receiverNickname, required this.senderProfileImg, required this.receiverProfileImg, required this.createdAt, required this.postBalance});

  // 기본 이미지 URL 설정
  static const String defaultProfileImg = 'assets/images/nullProfile.jpg';

  exchangeListUser.fromJson(Map<String, dynamic> json) {
    transId = json['transId'];
    send = json['send'];
    senderNickname = json['senderNickname'] ?? '';
    receiverNickname = json['receiverNickname']?? '';
    senderProfileImg = (json['senderProfileImg'] != null && json['senderProfileImg'].isNotEmpty)
        ? json['senderProfileImg']
        : defaultProfileImg;
    receiverProfileImg = (json['receiverProfileImg'] != null && json['receiverProfileImg'].isNotEmpty)
        ? json['receiverProfileImg']
        : defaultProfileImg;

    amount = json['amount'];
    postBalance = json['postBalance'];

    createdAt = json['createdAt'];
    createdAtToDaily = DateFormat('yyyy-MM-dd').format(DateTime.parse(json['createdAt']));
  }
}