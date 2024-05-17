import 'package:flutter/material.dart';
import 'package:suntown/main/drawer/inquiry/askQuestion.dart';
import '../../../utils/screenSizeUtil.dart';

class inquiryStart extends StatefulWidget {
  const inquiryStart({super.key});

  @override
  State<inquiryStart> createState() => _inquiryStartState();
}

class _inquiryStartState extends State<inquiryStart> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('질문하기'),
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
                        SizedBox(height: 59,),
                        CustomListTile(
                          title: Text('질문하기',
                            style: TextStyle(
                              color: Color(0xFF624A43),
                              fontSize: 20,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          spacing: 45.0, // 원하는 간격
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => askQuestion()));
                            print('질문하기 클릭');
                          },
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          height: 1.0,
                          width: screenWidth * 1.0,
                          color: Color(0xFFD3C2BD),
                        ),
                        SizedBox(height: screenHeight * 0.024),
                        CustomListTile(
                          title: Text('질문내역 보기',
                            style: TextStyle(
                              color: Color(0xFF624A43),
                              fontSize: 20,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          spacing: 45.0, // 원하는 간격
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => askQuestion()));
                            print('질문내역 보기 클릭');
                          },
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          height: 1.0,
                          width: screenWidth * 1.0,
                          color: Color(0xFFD3C2BD),
                        ),
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

class CustomListTile extends StatelessWidget {
  final Widget title;
  final Widget trailing;
  final double spacing;
  final VoidCallback? onTap;

  CustomListTile({
    required this.title,
    required this.trailing,
    this.spacing = 16.0, // 기본 간격
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(child: title),
            SizedBox(width: spacing),
            trailing,
          ],
        ),
      ),
    );
  }
}