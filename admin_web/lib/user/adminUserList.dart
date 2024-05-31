
/*
연동 리스트

{
    "inquireId": 29,
    "inquirerId": 75,
    "inquireType": 2,
    "inquireText": "거래 id: 0\n\n원래 보내려고 했던 금액: 0\n\n추가 문의사항: 취소",
    "createdAt": "2024-05-28T04:48:50",
    "updatedAt": "2024-05-28T04:48:50",
    "completed": false
},
 */

/*
"거래 id: 71
원래 보내려고 했던 금액: 10
추가 문의사항: 수정",
 */

class AdminUserList {
  late int inquireId; //문의 신청자..?
  late int inquirerId; //문의 대상...?
  late int inquireType;
  late String inquireText;
  late String createdAt;
  late String updatedAt;
  late bool completed;

  // 추가할 필드
  late int transactionId;
  late int originalAmount;
  late String additionalRequest;

  AdminUserList({required this.inquireId, required this.inquirerId, required this.inquireType, required this.inquireText, required this.createdAt, required this.updatedAt, required this.completed});

  // // 기본 이미지 URL 설정
  // static const String defaultProfileImg = 'assets/images/nullProfile.jpg';

  AdminUserList.fromJson(Map<String, dynamic> json) {
    inquireId = json['inquireId'];
    inquirerId = json['inquirerId'];
    inquireType = json['inquireType'];
    inquireText = json['inquireText'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    completed = json['completed'];

    // inquireText 필드를 분할하여 각 값을 추출
    var lines = inquireText.split('\n');
    transactionId = int.parse(lines[0].split(': ')[1]);
    originalAmount = int.parse(lines[2].split(': ')[1]);
    additionalRequest = lines[4].split(': ')[1];
  }
}