import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:suntown/main/alert/filter/listFilteringAlert.dart';
import 'package:suntown/main/accountList/listDetail.dart';

import '../../User/exchangeListUser/testUser.dart';
import '../../bubble.dart';
import '../../utils/api/exchangeList/listPost.dart';
import '../../utils/screenSizeUtil.dart';
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

  @override
  void initState() {
    super.initState();
    fetchData();
    dataUpdate = false;
  }

  Future<void> fetchData() async {
    try {
      final Map<String, dynamic> response = await listPost(type);
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
            "매듭 창고",
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
              height: screenHeight * 0.025,
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
                      fetchData();
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
                          fontSize: screenWidth * 0.055,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff624A43),
                        size: screenWidth * 0.08,
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
                    return ListTile(
                      contentPadding: EdgeInsets.all(0), // 패딩 제거
                      title: Row(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                users[index].send == true ? users[index].receiverProfileImg : users[index].senderProfileImg,
                              ),
                              radius: 30, // 원의 반지름 설정
                            ),
                          ),
                          Expanded(
                            child: Text(users[index].send == true ? users[index].receiverNickname : users[index].senderNickname
                              ,textAlign: TextAlign.left,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(users[index].send == true ? '- ${users[index].amount}매듭' : '+ ${users[index].amount}매듭',
                              style: TextStyle(
                                color: users[index].send == true ?  Color(0xff7D303D) : Color(0xff2C533C),
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
