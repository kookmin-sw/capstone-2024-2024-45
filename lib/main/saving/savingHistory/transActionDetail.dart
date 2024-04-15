import 'package:flutter/material.dart';

// TransactionDetailPage 클래스를 savingFilteringPopup.dart 파일에 추가합니다.
class TransactionDetailPage extends StatelessWidget {
  final Map<String, dynamic> transaction;

  TransactionDetailPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${transaction['name']}의 상세 내역'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(transaction['imageUrl']),
            ),
            Divider(height: 20, color: Colors.grey),
            Text(
              '이름: ${transaction['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '거래 유형: ${transaction['type']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '금액: ${transaction['amount']}',
              style: TextStyle(
                  fontSize: 16,
                  color:
                      transaction['type'] == '입금' ? Colors.green : Colors.red),
            ),
            Text(
              '거래일시: ${transaction['date']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
