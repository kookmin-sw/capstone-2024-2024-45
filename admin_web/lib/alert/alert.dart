import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AdminCorrAlert {
  static Future<void> showEditDialog(
      BuildContext context, {
        required String inquireId,
        required String inquirerId,
        required String originalAmount,
        required String additionalRequest,
      }) async {
    TextEditingController amountController =
    TextEditingController(text: originalAmount);
    TextEditingController reasonController = TextEditingController();

    String sender = inquirerId; // 실제 데이터로 바꿔야 함
    String receiver = inquireId; // 실제 데이터로 바꿔야 함
    String type = additionalRequest; // 기본 값
    String adminInfo = "Admin";

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 외부 터치로 닫히지 않도록 설정
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false; // true를 반환하여 AlertDialog가 닫히도록 함
          },
          child: AlertDialog(
            title: Center(
              child: Text("관리자 송금"),
            ),
            content: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "금액 수정",
                            groupValue: type,
                            onChanged: (value) {
                              setState(() {
                                type = value.toString();
                              });
                            },
                          ),
                          Text("금액 수정"),
                          Radio(
                            value: "거래 취소",
                            groupValue: type,
                            onChanged: (value) {
                              setState(() {
                                type = value.toString();
                              });
                            },
                          ),
                          Text("거래 취소"),
                        ],
                      ),
                      TextField(
                        controller: TextEditingController(text: sender),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '보내는 사람:',
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(text: receiver),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '받는 사람:',
                        ),
                      ),
                      TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: '금액 (TP):',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: TextEditingController(text: adminInfo),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '관리자 정보:',
                        ),
                      ),
                      TextField(
                        controller: reasonController,
                        decoration: InputDecoration(
                          labelText: '(관리자용) 송금 개입 이유:',
                          hintText: '사용자의 거래를 수정하거나 취소하는 이유를 작성하세요.',
                          hintStyle: TextStyle(color: Colors.red),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('실행'),
                onPressed: () {
                  // 실행 버튼 클릭 시 수행할 작업
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

