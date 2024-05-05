
/*
"data": [
    {
      "transId": 14,
      "send": true,
      "senderNickname": null,
      "senderProfileImg": null,
      "receiverNickname": "받은이",
      "receiverProfileImg": "받은이 프로필 이미지 url 이 들어갈 예정",
      "amount": 50
    },
  ]
 */

class exchangeListUser {
  late int transId;
  late bool send;
  late String senderNickname;
  late String receiverNickname;
  late String senderProfileImg;
  late String receiverProfileImg;
  late int amount;

  exchangeListUser({required this.transId, required this.amount, required this.senderNickname, required this.receiverNickname, required this.senderProfileImg, required this.receiverProfileImg});

  exchangeListUser.fromJson(Map<String, dynamic> json) {
    transId = json['transId'];
    send = json['send'];
    senderNickname = json['senderNickname'] ?? '';
    receiverNickname = json['receiverNickname']?? '';
    senderProfileImg = json['senderProfileImg']?? '';
    receiverProfileImg = json['receiverProfileImg']?? '';
    amount = json['amount'];
  }
}