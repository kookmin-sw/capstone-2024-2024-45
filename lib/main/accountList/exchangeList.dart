import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<exchangeListUser> users = [];

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
        List<exchangeListUser> fetchedUsers = [];
        for (var i = 0; i < response['data'].length; i++) {
          fetchedUsers.add(exchangeListUser.fromJson(response['data'][i]));
        }
        setState(() {
          users = fetchedUsers;
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
              height:(screenWidth < screenHeight) ? screenWidth * 0.025 : screenHeight * 0.025,
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
            Container( height:1.0,
              width:screenWidth * 1.0,
              color:Color(0xff624A43),),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String timeStr =
                        changeAmountToTime.changeAmountToTime(users[index].amount)[0] == 0 ? "${changeAmountToTime.changeAmountToTime(users[index].amount)[1]} 분"
                        : "${changeAmountToTime.changeAmountToTime(users[index].amount)[0]} 시간 ${changeAmountToTime.changeAmountToTime(users[index].amount)[1]} 분";
                    return ListTile(
                      contentPadding: EdgeInsets.all(0), // 패딩 제거
                      title: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                users[index].send == true ? users[index].receiverProfileImg : users[index].senderProfileImg,
                              ),
                              radius: 30, // 원의 반지름 설정
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(users[index].send == true ? users[index].receiverNickname : users[index].senderNickname
                              ,textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 4,
                            child: Text(
                              users[index].send == true
                                  ? '- ${timeStr}'
                              : '+ ${timeStr}',
                              style: TextStyle(
                                color: users[index].send == true ?  Color(0xff7D303D) : Color(0xff2C533C),
                                fontSize: 20
                              ),

                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => listDetail(
                              transId: users[index].transId, send : users[index].send
                          )),
                        );
                      },
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
