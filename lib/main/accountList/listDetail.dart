import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/exchangeListUser/testDetailUser.dart';

import '../../utils/api/exchangeList/listDetailPost.dart';
import '../../utils/screenSizeUtil.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';

class listDetail extends StatefulWidget {
  final int transId;
  final bool send;

  const listDetail({Key? key, required this.transId, required this.send})
      : super(key: key); // 명시적으로 부모 클래스의 생성자에 key를 전달합니다.

  @override
  State<listDetail> createState() => _TestWidget2State();
}

class _TestWidget2State extends State<listDetail> {
  late int _transId;
  late bool _send;
  late listDetailUser testDetailUser;
  late bool dataload;

  @override
  void initState() {
    super.initState();
    _transId = widget.transId;
    _send = widget.send;
    dataload = false;
    testDetailUser = listDetailUser();
    fetchData();
  }

  Future<void> fetchData() async {
    //의문, 이미 앞단에서 한 번 가져와서 클래스에 저장하는데 또 요청을 해야하나?
    try {
      final value =
          await listDetailPost(transId: _transId, send: _send); //여기서 2가 id이다.

      if (value["statusCode"] == 200) {
        //서버 응답
        if (value["status"] == 200) {
          //검증 완료
          testDetailUser.userInitializeData(value["data"]);
          if (testDetailUser.createdAt != '') {
            //일단 이럴일은 없으니, 이걸로 체크
            setState(() {
              dataload = true;
            });
          }
          // 데이터를 사용하여 setState() 호출
        } else if (value["status"] == 400) {
          ApiRequestFailAlert.showExpiredCodeDialog(
              context, listDetail(transId: _transId, send: _send));
        }
      } else {
        ApiRequestFailAlert.showExpiredCodeDialog(
            context, listDetail(transId: _transId, send: _send));
        debugPrint('서버 에러입니다. 다시 시도해주세요');
      }
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(
          context, listDetail(transId: _transId, send: _send));
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    return Scaffold(
      appBar: AppBar(),
      body: dataload
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            testDetailUser.sender == true
                                ? testDetailUser.receiverProfileImg
                                : testDetailUser.senderProfileImg,
                          ),
                          radius: screenWidth * 0.2, // 원의 반지름 설정
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Text(
                          testDetailUser.sender == true
                              ? testDetailUser.receiverNickname
                              : testDetailUser.senderNickname,
                          style: TextStyle(
                              color: Color(0xff4B4A48),
                              fontSize: screenWidth * 0.07,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Row(children: [
                          Expanded(
                            child: Text(
                              testDetailUser.formattedAmount + " 매듭",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: testDetailUser.sender == true ? Color(0xff7D303D) : Color(0xff2C533C),
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              testDetailUser.sender == true ? "보냄" : "받았음",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: testDetailUser.sender == true ? Color(0xff7D303D) : Color(0xff2C533C),
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          height: 2.0,
                          width: screenWidth * 1.0,
                          color: Color(0xff624A43),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SizedBox(height: screenHeight * 0.01),
                        Row(children: [
                          Expanded(
                            child: Text(
                              "잔액",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff4B4A48),
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              testDetailUser.sender == true
                                  ? testDetailUser.formattedReceiverBalanceAfter
                                          .toString() +
                                      " 매듭"
                                  : testDetailUser.formattedSenderBalanceAfter.toString() +
                                      " 매듭",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff4B4A48),
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(height: screenHeight * 0.01),
                        Row(children: [
                          Expanded(
                            child: Text(
                              "일시",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff4B4A48),
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 2,
                            child: Text(
                              testDetailUser.createdAt,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff4B4A48),
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]),
                      ]),
                    ),
                    Spacer(),
                    ElevatedButton(
                      child: Text(
                        '잘못 보내셨나요?',
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
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset("assets/lottie/loading.json"),
              ],
            )),
    );
  }
}
