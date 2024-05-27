import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:suntown/User/exchangeListUser/listDetailUser.dart';

import '../../User/exchangeListUser/exchangeListUser.dart';
import '../../utils/api/exchangeList/listDetailPost.dart';
import '../../utils/screenSizeUtil.dart';
import '../../utils/time/changeAmountToTime.dart';
import '../../utils/time/changeTimeToAmount.dart';
import '../alert/apiFail/ApiRequestFailAlert.dart';
import '../refund/chooseRufundAndCancel.dart';

class listDetail extends StatefulWidget {
  final exchangeListUser user;

  const listDetail({Key? key, required this.user})
      : super(key: key); // 명시적으로 부모 클래스의 생성자에 key를 전달합니다.

  @override
  State<listDetail> createState() => _TestWidget2State();
}

class _TestWidget2State extends State<listDetail> {
  late exchangeListUser testDetailUser;

  @override
  void initState() {
    super.initState();
    testDetailUser = widget.user;
  }

  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();
  ChangeTimeToAmount changeTimeToAmount = ChangeTimeToAmount();

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else {
      return AssetImage(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    String timeStr = changeAmountToTime
                .changeAmountToTime(testDetailUser.amount)[0] ==
            0
        ? "${changeAmountToTime.changeAmountToTime(testDetailUser.amount)[1]} 분"
        : "${changeAmountToTime.changeAmountToTime(testDetailUser.amount)[0]} 시간 ${changeAmountToTime.changeAmountToTime(testDetailUser.amount)[1]} 분";

    String amountTimeStr = changeAmountToTime.changeAmountToTime(testDetailUser.postBalance)[0] == 0 ?
    "${changeAmountToTime.changeAmountToTime(testDetailUser.postBalance)[1]} 분" :
    "${changeAmountToTime.changeAmountToTime(testDetailUser.postBalance)[0]} 시간 ${changeAmountToTime.changeAmountToTime(testDetailUser.postBalance)[1]} 분";

    print("---------testDetailUser.receiverProfileImg-----------");
    print(testDetailUser.receiverProfileImg);
    print("---------testDetailUser.senderProfileImg-----------");
    print(testDetailUser.senderProfileImg);

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
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
                      backgroundImage: testDetailUser.send == true
                          ? _getImageProvider(testDetailUser.receiverProfileImg)
                          : _getImageProvider(testDetailUser.senderProfileImg),
                      radius: 50, // 원의 반지름 설정
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      testDetailUser.send == true
                          ? testDetailUser.receiverNickname
                          : testDetailUser.senderNickname,
                      style: TextStyle(
                        color: Color(0xff4B4A48),
                        fontSize: 30,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(children: [
                      Expanded(
                        child: Text(
                          timeStr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: testDetailUser.send == true
                                ? Color(0xff7D303D)
                                : Color(0xff2C533C),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          testDetailUser.send == true ? "보냄" : "받음",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: testDetailUser.send == true
                                ? Color(0xff7D303D)
                                : Color(0xff2C533C),
                            fontSize: 20,
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
                    Row(children: [
                      Expanded(
                        child: Text(
                          "잔액",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xff4B4A48),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: Text(
                          amountTimeStr,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff4B4A48),
                            fontSize: 20,
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
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: Text(
                          testDetailUser.createdAtToDaily,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff4B4A48),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ]),
                  ]),
                ),
                Spacer(),
                testDetailUser.send
                    ? ElevatedButton(
                        child: Text(
                          '잘못 보내셨나요?',
                          style: TextStyle(
                            color: Color(0xff624A43),
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChooseRefundAndCancel()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(screenWidth * 0.85, screenHeight * 0.09),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Color(0xFFD3C2BD),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
