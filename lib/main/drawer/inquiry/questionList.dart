import 'package:flutter/material.dart';
import 'package:suntown/main/alert/filter/askStateFIltering.dart';
import 'package:suntown/main/alert/filter/questFilteringAlert.dart';
import 'package:suntown/main/drawer/inquiry/finishInquiry.dart';
import '../../../utils/screenSizeUtil.dart';


class QuestionList extends StatefulWidget {
  const QuestionList({super.key});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  String type = "ALL";
  String filterType = "모두";

  late TextEditingController _textEditingController;
  String memo = "";

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    memo = _textEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('질문 내역'),
        centerTitle: true,
        elevation : 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications), // 메뉴 아이콘
            onPressed: () {
              // 메뉴를 클릭했을 때 수행할 동작
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child:SingleChildScrollView(
                    child : Column(
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

                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              AskStateFilter.showExpiredCodeDialog(
                                context,
                                updateTypeCallback: (newType, newFilteringType) {
                                  setState(() {
                                    type = newType;
                                    filterType = newFilteringType;
                                  });
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
                          color: Color(0xFFD3C2BD),
                        ),
                        SizedBox(height: screenHeight * 0.024),
                      ],
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}

