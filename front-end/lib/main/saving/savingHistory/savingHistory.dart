import 'package:flutter/material.dart';

class Savinghistory extends StatefulWidget {
  Savinghistory({Key? key}) : super(key: key);

  @override
  _SavinghistoryState createState() => _SavinghistoryState();
}

class _SavinghistoryState extends State<Savinghistory> {
  final String accountBalance = '100,000원';
  final List<Map<String, String>> transactions = [
    {'type': '출금', 'amount': '30,000원'},
    {'type': '입금', 'amount': '50,000원'},
    {'type': '출금', 'amount': '20,000원'},
  ];

  String filter = '전체';

  void _showTransactionFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.money),
                title: Text('전체'),
                onTap: () {
                  setState(() {
                    filter = '전체';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('입금'),
                onTap: () {
                  setState(() {
                    filter = '입금';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.money_off),
                title: Text('출금'),
                onTap: () {
                  setState(() {
                    filter = '출금';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTransactions =
    transactions.where((transaction) {
      if (filter == '전체') return true;
      return transaction['type'] == filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('거래 확인하기')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('계좌1 잔액: $accountBalance', style: TextStyle(fontSize: 20)),
                ElevatedButton(
                  onPressed: () => _showTransactionFilter(context),
                  child: Text(filter),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        '${filteredTransactions[index]['type']}: ${filteredTransactions[index]['amount']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
