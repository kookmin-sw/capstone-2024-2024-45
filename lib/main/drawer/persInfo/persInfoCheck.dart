import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../manage/userInfoManage.dart';
import '../../../utils/screenSizeUtil.dart';
import '../../alert/apiFail/ApiRequestFailAlert.dart';
import '../../../User/userData/UserF.dart';

class persInfo extends StatefulWidget {

  @override
  State<persInfo> createState() => _persInfoState();
}

class _persInfoState extends State<persInfo> {

  late String userName ;
  late String mobile_number;
  late UserF user;
  late bool dataload;
  @override
  void initState() {
    dataload = false;
    user = UserF();
    fetchData();
  }

  // userdata 불러오기
  Future<void> fetchData() async {
    try {
      final value = await UserInfoManage().getUserInfo();
      dataload = true;
      user.initializeData(value["result"]['user_info']);
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(context, persInfo());
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }

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
                        radius: 50, // 원의 반지름 설정
                      ),
                      SizedBox(height: screenHeight * 0.024,),
                      // 이름
                      Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.09,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.045,
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
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.045,
                                child: Text(
                                  user.name,
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
                                width: screenWidth * 0.85,
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
                      SizedBox(height: screenHeight * 0.024),
                      // // 이메일
                      // Container(
                      //   width: screenWidth * 0.85,
                      //   height: screenHeight * 0.09,
                      //   child: Stack(
                      //     children: [
                      //       Positioned(
                      //         left: 0,
                      //         top: 0,
                      //         child: SizedBox(
                      //           width: screenWidth * 0.8,
                      //           height: screenHeight * 0.045,
                      //           child: Text(
                      //             '이메일',
                      //             style: TextStyle(
                      //               color: Color(0xFFD3C2BD),
                      //               fontSize: 17,
                      //               fontFamily: 'Noto Sans KR',
                      //               fontWeight: FontWeight.w700,
                      //               height: 0,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left: 0,
                      //         top: 39,
                      //         child: SizedBox(
                      //           width: screenWidth * 0.8,
                      //           height: screenHeight * 0.045,
                      //           child: Text(
                      //             'asdf1234@google.com',
                      //             style: TextStyle(
                      //               color: Color(0xFF624A43),
                      //               fontSize: 17,
                      //               fontFamily: 'Noto Sans KR',
                      //               fontWeight: FontWeight.w700,
                      //               height: 0,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left: 0,
                      //         top: 77,
                      //         child: Container(
                      //           width: screenWidth * 0.85,
                      //           decoration: ShapeDecoration(
                      //             shape: RoundedRectangleBorder(
                      //               side: BorderSide(
                      //                 width: 1,
                      //                 strokeAlign: BorderSide.strokeAlignCenter,
                      //                 color: Color(0xFFD3C2BD),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: screenHeight * 0.024),
                      // 전화번호
                      Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.09,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.045,
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
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.045,
                                child: Text(
                                  user.mobile_number,
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
                                width: screenWidth * 0.85,
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
              // 2차배포 때 활성화 시키기
              // ElevatedButton(
              //   child: Text(
              //     '수정하기',
              //     style: TextStyle(
              //       color: Color(0xff624A43),
              //       fontSize: screenWidth * 0.055,
              //       fontFamily: 'Noto Sans KR',
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              //   onPressed: () {
              //     // setState(() {
              //     //   Navigator.of(context).push(MaterialPageRoute(
              //     //       builder: (context) => testWidget()));
              //     // });
              //   },
              //   style: ElevatedButton.styleFrom(
              //     fixedSize: Size(screenWidth* 0.85, screenHeight * 0.09),
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     backgroundColor: Color(0xFFD3C2BD),
              //   ),
              // ),
            ],
          ),
        ),
      )
    );
  }
}
