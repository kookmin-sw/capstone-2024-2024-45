import 'package:flutter/material.dart';
import 'package:suntown/utils/api/inquiry/questionDetailGet.dart';

class QuestionDetail extends StatefulWidget {
  final String inquireId;

  const QuestionDetail({Key? key, required this.inquireId}) : super(key: key);

  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  late DateTime createdAt; // 변경: createdAt 변수를 DateTime 타입으로 변경

  late String inquireText;
  String? reply;

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
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('질문 상세 내역'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '작성일: ${createdAt.toString()}', // 변경: createdAt 변수를 문자열로 출력
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '질문 내용:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 5),
            Text(
              inquireText,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            if (reply != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    '답변:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    reply!,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
