import 'dart:math';

import 'package:admin_web/user/adminUserList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'alert/alert.dart';
import 'getTransactions.dart';

import 'package:flutter/material.dart';

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
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
      final Map<String, dynamic> response =
          await getTransactions(type: "REFUND", completion: false);
      if (response['statusCode'] == 200) {
        groupedData = []; // 한 번 초기화
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Center(child: Text('관리자 환불 페이지', style: TextStyle(fontSize: 25))),
      ),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child:
                          Text("관리자 : Admin", style: TextStyle(fontSize: 25))),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          color: Colors.white,
                          child: DataTable(
                            columnSpacing: 15.0, // 컬럼 간의 간격 조정
                            columns: <DataColumn>[
                              DataColumn(
                                label: Center(
                                  child: Text('거래Id',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('Created At',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('Updated At',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('문의대상 ID',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('문의자 ID',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('문의 타입',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('수정 요청 금액',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('문의 내용',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('완료 여부',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text('수행',
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ),
                            ],
                            rows: users.map((transaction) {
                              return DataRow(cells: [
                                DataCell(Center(
                                  child: Container(
                                      width: 50,
                                      child: Text(
                                          transaction.transactionId.toString(),
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Center(
                                  child: Container(
                                      width: 100,
                                      child: Text(transaction.createdAt,
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Center(
                                  child: Container(
                                      width: 100,
                                      child: Text(transaction.updatedAt,
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Center(
                                  child: Container(
                                      width: 100,
                                      child: Text(
                                          transaction.inquireId.toString(),
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Center(
                                  child: Container(
                                      width: 50,
                                      child: Text(
                                          transaction.inquirerId.toString(),
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Center(
                                  child: Container(
                                      width: 50,
                                      child: Text(
                                          transaction.inquireType.toString(),
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Container(
                                    width: 100,
                                    child: Text(
                                        transaction.originalAmount.toString(),
                                        style: TextStyle(fontSize: 12)))),
                                DataCell(Center(
                                  child: Container(
                                      width: 100,
                                      child: Text(transaction.additionalRequest,
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(Center(
                                  child: Container(
                                      width: 50,
                                      child: Text(
                                          transaction.completed.toString(),
                                          style: TextStyle(fontSize: 12))),
                                )),
                                DataCell(transaction.additionalRequest == "수정"
                                    ? Center(
                                        child: Container(
                                            width: 100,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // 수정 버튼 클릭시 수행할 작업
                                                AdminCorrAlert.showEditDialog(
                                                    inquirerId: transaction
                                                        .inquirerId
                                                        .toString(),
                                                    inquireId: transaction
                                                        .inquireId
                                                        .toString(),
                                                    originalAmount: transaction
                                                        .originalAmount
                                                        .toString(),
                                                    additionalRequest:
                                                        transaction
                                                            .additionalRequest,
                                                    context);
                                              },
                                              child: Text(
                                                '수정',
                                                style: TextStyle(
                                                    color: Color(0xFFDDE9E2)),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(50, 30),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    Color(0xFF2C533C),
                                              ),
                                            )),
                                      )
                                    : Center(
                                        child: Container(
                                            width: 100,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // 수정 버튼 클릭시 수행할 작업
                                                AdminCorrAlert.showEditDialog(
                                                    inquirerId: transaction
                                                        .inquirerId
                                                        .toString(),
                                                    inquireId: transaction
                                                        .inquireId
                                                        .toString(),
                                                    originalAmount: transaction
                                                        .originalAmount
                                                        .toString(),
                                                    additionalRequest:
                                                        transaction
                                                            .additionalRequest,
                                                    context);
                                              },
                                              child: Text(
                                                '취소',
                                                style: TextStyle(
                                                    color: Color(0xFF2C533C)),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(50, 30),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    Color(0xFFDDE9E2),
                                              ),
                                            )),
                                      )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
