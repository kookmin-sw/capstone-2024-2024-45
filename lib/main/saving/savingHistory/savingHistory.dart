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
        return AlertDialog(
          title: Text('어떤걸 볼까요?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = [true, false, false];
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('주고받은 매듭 확인하기'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = [false, true, false];
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('받은 매듭만 확인하기'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = [false, false, true];
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('보낸 매듭만 확인하기'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
      appBar: AppBar(title: Text('주고 받은 매듭 확인하기')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xffF8E4E4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text('\u{1F970} 환불을 원하시면, 해당 거래를 눌러주세요',
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: TextButton.icon(
                icon: Icon(Icons.arrow_drop_down,
                    size: 24), // This is the "v" icon
                label: Text('전체'),
                onPressed: _showFilterOptions,
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: groupedTransactions.entries.map((entry) {
                return Column(
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
                            ? Colors.red
                            : Colors.blue;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(transaction['imageUrl']),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Savinghistory()));
}
