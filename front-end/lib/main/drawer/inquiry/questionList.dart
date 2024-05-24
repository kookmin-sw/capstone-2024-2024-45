import 'package:flutter/material.dart';
import 'package:suntown/main/drawer/inquiry/questionDetail.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/utils/api/inquiry/questionlistGet.dart';
import '../../../utils/screenSizeUtil.dart';
import 'package:intl/intl.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({super.key});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  String? user_id;
  List<Map<String, dynamic>> extractedData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // 데이터 가져오기
  Future<void> fetchData() async {
    user_id = await UserInfoManage().getUserId() ?? '';
    final response = await QuestionListGet(user_id: user_id);
    if (response['statusCode'] == 200) {
      List<Map<String, dynamic>> tempList = [];
      for (var item in response['data']) {
        if (item['inquireType'] == 1) {
          tempList.add({
            'inquireId': item['inquireId'],
            'createdAt': item['createdAt'],
            'inquireText': item['inquireText'].replaceFirst('거래 id: 0\n\n', ''),
          });
        }
      }
      setState(() {
        extractedData = tempList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('질문 내역'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  // width: 294,
                  height: 35,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '내 질문 목록',
                      style: TextStyle(
                        color: Color(0xFF4B4A48),
                        fontSize: 25,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: 1.2,
                  width: screenWidth * 1.0,
                  color: Color(0xFFD3C2BD),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: extractedData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('질문 내용: \n${truncateText(extractedData[index]['inquireText'], 50)}\n'),
                        subtitle: Text('작성일: ${formatDate(extractedData[index]['createdAt'])}'),
                        onTap: () {
                          String inquireId = extractedData[index]['inquireId'].toString();
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionDetail(inquireId: inquireId)));
                          // Handle tap event, e.g., navigate to detail page or show more info
                          print('Inquire ID: $inquireId');
                        },
                      ),
                      Divider(), // Add a divider between items
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
