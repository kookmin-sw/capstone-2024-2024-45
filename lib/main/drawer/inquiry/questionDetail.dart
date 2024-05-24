import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/utils/api/inquiry/questionDetailGet.dart';
import 'package:suntown/utils/screenSizeUtil.dart';
import 'package:intl/intl.dart';

class QuestionDetail extends StatefulWidget {
  final String inquireId;

  const QuestionDetail({Key? key, required this.inquireId}) : super(key: key);

  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  DateTime createdAt = DateTime.now(); // 변경: createdAt 변수를 DateTime 타입으로 변경

  late String inquireText;
  String? reply;
  bool dataLoad = false;
  @override
  void initState() {
    super.initState();
    fetchData(); // 데이터 가져오기 메서드 호출
  }

  // 데이터 가져오기
  Future<void> fetchData() async {
    final response = await QuestionDetailGet(inquireId: widget.inquireId);
    if (response['status'] == 200) {
      setState(() {
        createdAt = DateTime.parse(response['data']['inquire']['createdAt']); // 변경: DateTime.parse를 사용하여 문자열을 DateTime으로 변환
        inquireText = response['data']['inquire']['inquireText'];
        reply = response['data']['reply'];
        dataLoad = true;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // 날짜 form 설정
  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd HH:mm').format(parsedDate); // 초를 포함한 형식으로 변경
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('질문 상세 내역'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: dataLoad
          ?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '작성일: ${formatDate(createdAt.toString())}',
                    style: TextStyle(
                      color: Color(0xFF4B4A48),
                      fontSize: 17,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 35,
                child: Text(
                  '질문 내용',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: 1.2,
                width: screenWidth * 1.0,
                color: Color(0xFFD3C2BD),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: SingleChildScrollView( // SingleChildScrollView를 추가하여 스크롤이 가능한 컨테이너 생성
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inquireText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF4B4A48),
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 35,
                child: Text(
                  '답변',
                  style: TextStyle(
                    color: Color(0xFF4B4A48),
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: 1.2,
                width: screenWidth * 1.0,
                color: Color(0xFFD3C2BD),
              ),
              if (reply != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView( // SingleChildScrollView를 추가하여 스크롤이 가능한 컨테이너 생성
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reply!,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF4B4A48),
                                fontSize: 20,
                                fontFamily: 'Noto Sans KR',
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ): Lottie.asset("assets/lottie/loading.json"),
        )
      )
    );
  }
}
