import 'package:flutter/material.dart';
import 'package:suntown/main/saving/savingHistory/transActionDetail.dart';

class Savinghistory extends StatefulWidget {
  Savinghistory({Key? key}) : super(key: key);

  @override
  _SavinghistoryState createState() => _SavinghistoryState();
}

class _SavinghistoryState extends State<Savinghistory> {
  final String accountBalance = '100,000매듭';
  final List<Map<String, dynamic>> transactions = [
    {
      'type': '출금',
      'amount': '30,000매듭',
      'name': '김철수',
      'date': '2024.02.11',
      'imageUrl': 'https://via.placeholder.com/42x42'
    },
    {
      'type': '입금',
      'amount': '50,000매듭',
      'name': '홍길동',
      'date': '2024.02.10',
      'imageUrl': 'https://via.placeholder.com/42x42'
    },
    {
      'type': '출금',
      'amount': '20,000매듭',
      'name': '이영희',
      'date': '2024.02.10',
      'imageUrl': 'https://via.placeholder.com/42x42'
    },
  ];

  List<bool> isSelected = [true, false, false];

  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 345,
            height: 344,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '어떤걸 볼까요?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _filterOption('주고받은 매듭 확인하기'),
                _filterOption('받은 매듭만 확인하기'),
                _filterOption('보낸 매듭만 확인하기'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filterOption(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          switch (text) {
            case '주고받은 매듭 확인하기':
              isSelected = [true, false, false];
              break;
            case '받은 매듭만 확인하기':
              isSelected = [false, true, false];
              break;
            case '보낸 매듭만 확인하기':
              isSelected = [false, false, true];
              break;
          }
        });
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFFFE2E2), width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF4B4A48),
            fontSize: 20,
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in transactions.where((t) =>
        isSelected[0] ||
        (isSelected[1] && t['type'] == '입금') ||
        (isSelected[2] && t['type'] == '출금'))) {
      groupedTransactions
          .putIfAbsent(transaction['date'], () => [])
          .add(transaction);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('주고 받은 매듭 확인하기'),
        backgroundColor: Color(0xFFFFE795), // Adjusted AppBar color
      ),
      body: Container(
        color: Color(0xFFFFF6F6), // Light pink background for the entire page
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFFFE2E2), // Light pink header background
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '환불을 원하시면,\n해당 거래를 눌러주세요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: TextButton.icon(
                  icon: Icon(Icons.arrow_drop_down, size: 24),
                  label: Text('전체'),
                  onPressed: _showFilterOptions,
                  style:
                      TextButton.styleFrom(textStyle: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: groupedTransactions.entries.map((entry) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0), // Added indentation
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            entry.key,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: entry.value.map((transaction) {
                            var sign = transaction['type'] == '입금' ? '+' : '-';
                            var color = transaction['type'] == '입금'
                                ? Colors.blue
                                : Colors.red;
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(transaction['imageUrl']),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('${transaction['name']}'),
                                  ),
                                  Text('$sign${transaction['amount']}',
                                      style: TextStyle(color: color)),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransactionDetailPage(
                                        transaction: transaction),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Savinghistory()));
}
