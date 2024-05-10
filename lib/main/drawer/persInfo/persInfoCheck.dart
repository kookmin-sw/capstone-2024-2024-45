import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'testUserInfo.dart';
import '../../../utils/screenSizeUtil.dart';
import '../../alert/apiFail/ApiRequestFailAlert.dart';
import '../../../User/userData/User.dart';

class persInfo extends StatefulWidget {

  @override
  State<persInfo> createState() => _persInfoState();
}

class _persInfoState extends State<persInfo> {

  // late String userName ;
  // late String mobile_number;
  // late String email;
  // late String profile ;
  // late User testUser;
  // // late bool dataload;
  // @override
  // void initState() {
  //   // dataload = false;
  //   testUser = User();
  //   final value = fetchData();
  // }
  //
  // // userdata 불러오기
  // Future<void> fetchData() async {
  //   try {
  //     final value =
  //     await testUserGet();
  //
  //     if (value["statusCode"] == 200) {
  //       //서버 응답
  //       if (value["status"] == 200) {
  //         testUser.initializeData(value["data"]);
  //       } else if (value["status"] == 400) {
  //         ApiRequestFailAlert.showExpiredCodeDialog(context, persInfo());
  //       }
  //     } else {
  //       ApiRequestFailAlert.showExpiredCodeDialog(context, persInfo());
  //       debugPrint('서버 에러입니다. 다시 시도해주세요');
  //     }
  //   } catch (e) {
  //     ApiRequestFailAlert.showExpiredCodeDialog(context, persInfo());
  //     debugPrint('API 요청 중 오류가 발생했습니다: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child : Column(
                    children: <Widget>[
                      CircleAvatar(
                        // backgroundImage: NetworkImage(testUser.avatar),
                        backgroundImage : AssetImage('assets/images/default_profile.jpeg'),
                        radius: screenWidth * 0.15, // 원의 반지름 설정
                      ),
                      SizedBox(height: 20,),
                      // 이름
                      Container(
                        width: 343,
                        height: 77,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 294,
                                height: 35,
                                child: Text(
                                  '이름',
                                  style: TextStyle(
                                    color: Color(0xFFD3C2BD),
                                    fontSize: 17,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 39,
                              child: SizedBox(
                                width: 294,
                                height: 35,
                                child: Text(
                                  // testUser.firstName,
                                  "김국민",
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
                            Positioned(
                              left: 0,
                              top: 77,
                              child: Container(
                                width: 343,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFD3C2BD),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // 이메일
                      Container(
                        width: 343,
                        height: 77,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 294,
                                height: 35,
                                child: Text(
                                  '이메일',
                                  style: TextStyle(
                                    color: Color(0xFFD3C2BD),
                                    fontSize: 17,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 39,
                              child: SizedBox(
                                width: 294,
                                height: 35,
                                child: Text(
                                  'asdf1234@google.com',
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
                            Positioned(
                              left: 0,
                              top: 77,
                              child: Container(
                                width: 343,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFD3C2BD),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // 전화번호
                      Container(
                        width: 343,
                        height: 77,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 294,
                                height: 35,
                                child: Text(
                                  '전화번호',
                                  style: TextStyle(
                                    color: Color(0xFFD3C2BD),
                                    fontSize: 17,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 39,
                              child: SizedBox(
                                width: 294,
                                height: 35,
                                child: Text(
                                  '010-1234-5678',
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
                            Positioned(
                              left: 0,
                              top: 77,
                              child: Container(
                                width: 343,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFD3C2BD),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
              ElevatedButton(
                child: Text(
                  '수정하기',
                  style: TextStyle(
                    color: Color(0xff624A43),
                    fontSize: screenWidth * 0.055,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  // setState(() {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => testWidget()));
                  // });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Color(0xFFD3C2BD),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
