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
      final Map<String, dynamic> response = await getTransactions(type: "REFUND", completion: false);
      if (response['statusCode'] == 200) {
        groupedData = []; //한 번 초기화
        for (var i = 0; i < response['data'].length; i++) {
          groupedData.add(AdminUserList.fromJson(response['data'][i]));
          setState(() {
            users = groupedData;
            print("-----------------user 정보------------------------");
            print(users);
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

  //일단 표가 잘 나오는지 먼저 봐야함

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transaction List'),
        ),
        body: users.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Inquire ID')),
              DataColumn(label: Text('Inquirer ID')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Text')),
              DataColumn(label: Text('Created At')),
              DataColumn(label: Text('Updated At')),
              DataColumn(label: Text('Completed')),
            ],
            rows: users.map((transaction) {
              return DataRow(cells: [
                DataCell(Text(transaction.inquireId.toString())),
                DataCell(Text(transaction.inquirerId.toString())),
                DataCell(Text(transaction.inquireType.toString())),
                DataCell(Text(transaction.inquireText)),
                DataCell(Text(transaction.createdAt)),
                DataCell(Text(transaction.updatedAt)),
                DataCell(Text(transaction.completed.toString())),
              ]);
            }).toList(),
          ),
        ),
    );
  }
}
