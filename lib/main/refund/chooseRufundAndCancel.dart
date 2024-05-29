import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suntown/main/refund/minutesRefundInput.dart';
import 'package:suntown/main/refund/refundInput.dart';

import '../../User/exchangeListUser/exchangeListUser.dart';
import '../../User/exchangeListUser/listDetailUser.dart';
import '../../User/refundUserData/RefundUser.dart';
import '../../utils/screenSizeUtil.dart';
import '../../utils/time/changeAmountToTime.dart';
import '../../utils/time/changeTimeToAmount.dart';
import 'finishRefund.dart';
import 'loadingRefund.dart';

class ChooseRefundAndCancel extends StatefulWidget {
  final exchangeListUser user;
  const ChooseRefundAndCancel({Key? key, required this.user})
      : super(key: key);

  @override
  State<ChooseRefundAndCancel> createState() => _ChooseRefundAndCancelState();
}

class _ChooseRefundAndCancelState extends State<ChooseRefundAndCancel> {
  late exchangeListUser detailUser;
  late RefundUser refundUser;

  ChangeAmountToTime changeAmountToTime = ChangeAmountToTime();

  @override
  void initState() {
    super.initState();
    detailUser = widget.user;
    refundUser = RefundUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);

    refundUser.transId = detailUser.transId;

    String timeStr = changeAmountToTime.changeAmountToTime(detailUser.amount)[0] == 0 ?
    "${changeAmountToTime.changeAmountToTime(detailUser.amount)[1]} 분" :
    "${changeAmountToTime.changeAmountToTime(detailUser.amount)[0]} 시간 ${changeAmountToTime.changeAmountToTime(detailUser.amount)[1]} 분";


    return Scaffold(
      appBar:
      AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${detailUser.receiverNickname} ',
                            style: TextStyle(
                              color: Color(0xFF624A43),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '님에게 보낸',
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${timeStr} ',
                            style: TextStyle(
                              color: Color(0xFF624A43),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '을..',
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '수정',
                            style: TextStyle(
                              color: Color(0xFF2C533C),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '하고 싶으신가요?',
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '취소',
                            style: TextStyle(
                              color: Color(0xFF7D303D),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '하고 싶으신가요?',
                            style: TextStyle(
                              color: Color(0xFF4B4A48),
                              fontSize: 30,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                ElevatedButton(
                  child: Text(
                    '수정할래요!',
                    style: TextStyle(
                      color: Color(0xFFDDE9E2),
                      fontSize: 20,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      refundUser.inquire = "수정";
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RefundInput()));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.85, screenHeight * 0.09),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF2C533C),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                ElevatedButton(
                  child: Text(
                    '취소할래요!',
                    style: TextStyle(
                      color: Color(0xFFD3C2BD),
                      fontSize: 20,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      refundUser.inquire = "취소";
                      refundUser.expectedAmount = detailUser.amount.toString(); //전체를 환불
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoadingRefund()));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.85, screenHeight * 0.09),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF7D303D),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
