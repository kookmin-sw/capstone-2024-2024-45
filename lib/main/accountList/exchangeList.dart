import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:suntown/main/alert/filter/listFilteringAlert.dart';
import 'package:suntown/main/accountList/listDetail.dart';

import '../../User/exchangeListUser/exchangeListUser.dart';
import '../../User/test/testAccountData.dart';
import '../../bubble.dart';
import '../../utils/api/exchangeList/listPost.dart';
import '../../utils/screenSizeUtil.dart';
import '../../utils/time/changeAmountToTime.dart';
import '../../utils/time/changeTimeToAmount.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class exchangeList extends StatefulWidget {
  const exchangeList({super.key});

  @override
  State<exchangeList> createState() => _exchangeListState();
}

class _exchangeListState extends State<exchangeList> {
  late bool dataUpdate;
  late exchangeListUser testUser;
  String type = "ALL";
  String filterType = "전체";
  Map<String, List<exchangeListUser>> users = {};

// 데이터를 그룹화할 Map 생성
  Map<String, List<exchangeListUser>> groupedData = {};

  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();
  ChangeTimeToAmount changeTimeToAmount = ChangeTimeToAmount();

  TestAccountData testAccountData = TestAccountData();

  @override
  void initState() {
    super.initState();
    fetchData(testAccountData.accountId);
    dataUpdate = false;
  }

  Future<void> fetchData(String accountId) async {
    try {
      final Map<String, dynamic> response = await listPost(type, accountId);
      if (response['statusCode'] == 200) {
        groupedData = {}; //한 번 초기화
        for (var i = 0; i < response['data'].length; i++) {
          String date =
              exchangeListUser.fromJson(response['data'][i]).createdAtToDaily;
          if (!groupedData.containsKey(date)) {
            groupedData[date] = [];
          }
          groupedData[date]!
              .add(exchangeListUser.fromJson(response['data'][i]));
        }
        setState(() {
          users = groupedData;
          // print("-----------------user 정보------------------------");
          // print(users);
        });
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
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "시간 은행",
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          // 빈 아이콘을 추가하여 빈 공간을 만듭니다.
          IconButton(
            icon: Container(),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TopSideBubble(),
            SizedBox(
              height: (screenWidth < screenHeight)
                  ? screenWidth * 0.025
                  : screenHeight * 0.025,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  listFilteringAlert.showExpiredCodeDialog(
                    context,
                    updateTypeCallback: (newType, newFilteringType) {
                      setState(() {
                        type = newType;
                        filterType = newFilteringType;
                      });
                      fetchData(testAccountData.accountId);
                    },
                  ); // 콜백 함수 전달);
                },
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        filterType,
                        style: TextStyle(
                          color: Color(0xff624A43),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff624A43),
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              height: 1.0,
              width: screenWidth * 1.0,
              color: Color(0xff624A43),
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var date = users.keys.elementAt(index);
                    var transactions = users[date]!;

                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                date,
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
                        ), // 날짜 표시
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            String timeStr = changeAmountToTime
                                        .changeAmountToTime(
                                            transactions[index].amount)[0] ==
                                    0
                                ? "${changeAmountToTime.changeAmountToTime(transactions[index].amount)[1]} 분"
                                : "${changeAmountToTime.changeAmountToTime(transactions[index].amount)[0]} 시간 ${changeAmountToTime.changeAmountToTime(transactions[index].amount)[1]} 분";

                            return ListTile(
                              contentPadding: EdgeInsets.all(0), // 패딩 제거
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        transactions[index].send == true
                                            ? transactions[index]
                                                .receiverProfileImg
                                            : transactions[index]
                                                .senderProfileImg,
                                      ),
                                      radius: 30, // 원의 반지름 설정
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      transactions[index].send == true
                                          ? transactions[index].receiverNickname
                                          : transactions[index].senderNickname,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      transactions[index].send == true
                                          ? '- ${timeStr}'
                                          : '+ ${timeStr}',
                                      style: TextStyle(
                                          color:
                                              transactions[index].send == true
                                                  ? Color(0xff7D303D)
                                                  : Color(0xff2C533C),
                                          fontSize: 20),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              // 각 항목에 대한 추가 구성 요소 추가 가능
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => listDetail(
                                          transId: transactions[index].transId,
                                          send: transactions[index].send)),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
