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
        body: ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var transactions = users[index]!;
              return Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        transactions.first_name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xff737373),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ]);
            }));
  }
}
