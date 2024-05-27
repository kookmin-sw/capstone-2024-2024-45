
import 'dart:math';

import 'package:admin_web/user/adminUserList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'getTransactions.dart';

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  // final ApiService apiService = ApiService();
  // Future<List<dynamic>>? _transactions;

  late AdminUserList adminUserList;
  List<AdminUserList> users = [];
// 데이터를 그룹화할 Map 생성
  late List<AdminUserList> groupedData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final Map<String, dynamic> response = await getTransactions();
      if (response['statusCode'] == 200) {
        groupedData = []; //한 번 초기화
        for (var i = 0; i < response['data'].length; i++) {
          groupedData.add(AdminUserList.fromJson(response['data'][i]));
          setState(() {
            users = groupedData;
            // print("-----------------user 정보------------------------");
            // print(users);
          });
        }
      } else {
        // Handle error
        print('Error: ${response['statusCode']}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction List'),
      ),
      body: FutureBuilder<List<dynamic>>( //이거 리스트뷰로 변경
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                return ListTile(
                  title: Text('${transaction['sender']} -> ${transaction['receiver']}'),
                  subtitle: Text('Amount: ${transaction['amount']} TP'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(transaction),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.cancel),
                      //   onPressed: () => _cancelTransaction(transaction['id']),
                      // ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
