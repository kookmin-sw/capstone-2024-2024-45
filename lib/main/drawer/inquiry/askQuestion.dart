import 'package:flutter/material.dart';
import 'package:suntown/main/alert/filter/questFilteringAlert.dart';
import 'package:suntown/main/drawer/inquiry/finishInquiry.dart';
import '../../../utils/screenSizeUtil.dart';


class askQuestion extends StatefulWidget {
  const askQuestion({super.key});

  @override
  State<askQuestion> createState() => _askQuestionState();
}

class _askQuestionState extends State<askQuestion> {
  String type = "Default";
  String filterType = "질문 유형";

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
        title: Text('무엇이든 물어보세요!'),
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
                              '궁금한 내용을 남겨주세요.',
                              style: TextStyle(
                                color: Color(0xFF4B4A48),
                                fontSize: 20,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // width: 342,
                          height: 35,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '답변은 1주일 이내로, 완료됩니다.',
                              style: TextStyle(
                                color: Color(0xFF727272),
                                fontSize: 17,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              questFilterAlert.showExpiredCodeDialog(
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
                        SizedBox(
                          height: 35,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '질문 내용',
                              style: TextStyle(
                                color: Color(0xFF624A43),
                                fontSize: 17,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          child :TextField(
                            controller: _textEditingController, // 컨트롤러 연결
                            maxLines: null, // 여러 줄 입력 허용
                            keyboardType: TextInputType.multiline,
                            maxLength: 1000,
                            expands: true,
                            onChanged: (text) {
                              setState(() {
                                memo = text;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Color(0xFF2C533C)),
                              hintText: '질문 내용을 입력하세요...',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0), // 외곽선 둥글기 설정
                                borderSide: BorderSide(
                                  color: Color(0xFFDDE8E1), // 외곽선 색상 변경
                                ),
                              ),
                              filled: true, // 배경 색상 채우기 활성화
                              fillColor: Color(0xFFDDE8E1), // 배경 색상 설정
                            ),
                          )
                        ),
                      ],
                    )
                )
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FinishInquiry()));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                backgroundColor: const Color(0xFFDDE8E1),
                minimumSize: Size.fromHeight(73),

                foregroundColor: Colors.white ,//Color(0xFF4B4A48),

                textStyle: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("질문하기",
                  style: TextStyle(
                  color: Color(0xFF2C533C),
                    fontSize: 25,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

