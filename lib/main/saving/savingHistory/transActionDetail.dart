import 'package:flutter/material.dart';

class TransactionDetailPage extends StatelessWidget {
  final Map<String, dynamic> transaction;

  TransactionDetailPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const backgroundColor = Color(0xFFFFF6F6);
    const headerColor = Color(0xFFFFE795);
    const textColor = Color(0xFF4B4A48);
    const detailTextColor = Color(0xFF727272);

    // 거래 유형에 따른 색상 및 상태 텍스트 결정
    Color amountColor = transaction['type'] == '입금' ? Colors.blue : Colors.red;
    String statusText = transaction['type'] == '입금' ? '받음' : '보냈음';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        title: Text('${transaction['name']}의 상세 내역',
            style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(transaction['imageUrl']),
            ),
            SizedBox(height: 20),
            Text(
              transaction['name'],
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: 'Noto Sans KR',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${transaction['amount']}',
                  style: TextStyle(
                    fontSize: 25,
                    color: amountColor,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontFamily: 'Noto Sans KR',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '잔액',
                  style: TextStyle(
                      fontSize: 20,
                      color: detailTextColor,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '0원',
                  style: TextStyle(
                      fontSize: 20,
                      color: detailTextColor,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '일시',
                  style: TextStyle(
                      fontSize: 20,
                      color: detailTextColor,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  transaction['date'],
                  style: TextStyle(
                      fontSize: 20,
                      color: detailTextColor,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20),
            // 잘못 보내셨나요? 버튼 추가
            ElevatedButton(
              onPressed: () {
                // 버튼이 눌리면 무엇을 할지 정의
                // 여기서는 도움말을 표시하거나 필요한 작업을 수행할 수 있어요.
              },
              child: Text('잘못 보내셨나요?'),
            ),
          ],
        ),
      ),
    );
  }
}
