import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/permission/permissionNotifier.dart';

import '../utils/screenSizeUtil.dart';

import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:suntown/main/manage/accountInfoManage.dart';
import 'package:suntown/main/manage/userInfoManage.dart';
import 'package:suntown/main/signingUp/signingScreen.dart';
import 'package:suntown/main/defaultAccount.dart';


class PermissionContent extends StatefulWidget {
  @override
  State<PermissionContent> createState() => _PermissionContentState();
}

class _PermissionContentState extends State<PermissionContent> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    final provider = Provider.of<PermissionNotifier>(context, listen: false);
    bool isAgree = provider.isPermissionGranted;

    // 위젯을 빌드할 때마다 권한 상태를 업데이트
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        provider.checkAndUpdatePermissionStatusFromSettings();
        isAgree = provider.isPermissionGranted;
      });
    });

    return Container(
      child: Expanded(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.47,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFD3C2BD)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      child: Image(
                        image: AssetImage('assets/images/knot.png'),
                      ),
                    ),
                    Text(
                      "카메라",
                      style: TextStyle(
                        color: Color(0xff4B4A48),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ]),
                  Divider(
                    thickness: 1,
                    color: Color(0xffD3C2BD),
                  ),
                  Text(
                    '“시간은행” 송금을 진행 하려면,\n타임 코드를 카메라로 스캔해야 합니다.\n이를 위해 카메라 권한이 필요합니다.',
                    style: TextStyle(
                      color: Color(0xff4B4A48),
                      fontSize: 17,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      child: Image(
                        image: AssetImage('assets/images/knot.png'),
                      ),
                    ),
                  ]
                ),
                SizedBox(
                  width: screenWidth * 0.03
                  ,
                ),
                Text(
                  '권한 허용 후, 시간은행을 시작합니다.\n아래 “권한 설정하기” 버튼을 눌러서\n권한을 허용해주세요',
                  style: TextStyle(
                    color: Color(0xFF727272),
                    fontSize: 17,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  textAlign: TextAlign.left, // 텍스트를 왼쪽으로 정렬
                ),
              ],
            ),
            Spacer(),
            !isAgree
                ? ElevatedButton(
                    onPressed: () {
                      provider.requestCameraPermission(context);
                      // 상태를 업데이트하고 버튼 텍스트를 변경
                      setState(() {});
                    },
                    child: const Text(
                      '권한 설정',
                      style: TextStyle(
                        color: Color(0xffDDE9E2),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF2C533C),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
                        if (user != null) { // 로그인된 User가 존재하면 account 화면으로
                          try{
                            String user_id = await UserInfoManage().getUserId() ?? '';
                            String account_id = await AccountInfoMange().getAccount_id(user_id:user_id);
                            if(account_id.length > 0){ // 계좌가 생성된 user면 Main계좌 화면으로
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainAccount()));
                            }else { // 계좌가 생성되지 않은 user면 계좌 만들기 화면으로
                              Navigator.push(context, MaterialPageRoute(builder: (context) => defaultAccount()));
                            }
                          }catch (e) { // 만약 user_id를 가져오거나 account_id를 불러오는데 문제가 생겼다면 아직 회원가입이 안되어 있어 계좌가 없는 유저일 가능성이 큼.
                            print(e);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => defaultAccount()));
                          }
                        }else{ // 로그인된 User가 없으면 로그인 화면으로
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => signingUP()));
                        }
                      });
                    },
                    child: const Text(
                      '앱 시작하기',
                      style: TextStyle(
                        color: Color(0xFF2C533C),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFFDDE9E2),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
