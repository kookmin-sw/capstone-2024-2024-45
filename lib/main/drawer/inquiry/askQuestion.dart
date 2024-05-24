import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/main/alert/filter/questFilteringAlert.dart';
import 'package:suntown/main/drawer/inquiry/finishInquiry.dart';
import 'package:suntown/utils/api/inquiry/questionPost.dart';
import '../../../utils/screenSizeUtil.dart';

class askQuestion extends StatefulWidget {
  const askQuestion({super.key});

  @override
  State<askQuestion> createState() => _askQuestionState();
}

class _askQuestionState extends State<askQuestion> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  late String userId;
  bool dataload = false;

  late TextEditingController _textEditingController;
  String memoText = "";

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    memoText = _textEditingController.text;
    _initializeUserId();
  }

  // _userId를 초기화하는 메서드
  void _initializeUserId() {
    secureStorage.read(key: 'userId').then((value) {
      setState(() {
        userId = value ?? ""; // 값이 null인 경우 빈 문자열로 초기화
        dataload = true;
      });
    }).catchError((error) {
      debugPrint('userId를 읽어오는 중 오류 발생: $error');
    });
  }

  fetchInquiry({required userId, required memoText}) async {
    bool state = false;
    try {
      final value = await QuestionPost(user_id: userId, memoText: memoText);
      if (value["statusCode"] == 200) {
        print(value['message']);
        state = true;
      } else if(value["statusCode"] == 400){
        print(value['message']);
        debugPrint('inquiry post 에러');
      }else {
        print(value['message']);
        debugPrint('서버 에러입니다. 다시 시도해주세요');
        throw Exception('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
    return state;
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
                                color: Color(0xFF2C533C),
                                fontSize: 17,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          height: 200,
                          child :TextField(
                            controller: _textEditingController, // 컨트롤러 연결
                            maxLines: null, // 여러 줄 입력 허용
                            keyboardType: TextInputType.multiline,
                            maxLength: 500,
                            expands: true,
                            onChanged: (text) {
                              setState(() {
                                memoText = text;
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Color(0xFF2C533C)),
                              hintText: '내용을 입력하세요...',
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
              onPressed: memoText.length > 3 ?() async {
                if (userId.isNotEmpty) {
                  bool postSuccess = await fetchInquiry(
                      userId: userId, memoText: memoText);
                  print('userid ---------------$userId');
                  if (postSuccess) {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => FinishInquiry()));
                    print("질문 등록 성공 -----------");
                  }
                  else {
                    print('질문 등록 실패-----------');
                  }
                }else{
                  print('userId 초기화 안됨');
                }
              }:null,
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

