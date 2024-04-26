import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suntown/main/mainAccount.dart';
import 'package:suntown/permission/permissionNotifier.dart';

import '../utils/screenSizeUtil.dart';

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
        isAgree = provider.isPermissionGranted;
      });
    });

    return Container(
      child: Expanded(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFF9DEDE)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "provider.isPermissionGranted = ${provider.isPermissionGranted}"
            ),
            Spacer(),
            !isAgree
                ? ElevatedButton(
                    onPressed: () {
                      provider.requestCameraPermission(
                          context);
                    },
                    child: const Text(
                      '권한 설정',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(screenWidth * 0.85, screenHeight * 0.08),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF4B4A48),
                    ),
                  )
                : ElevatedButton( //일단 임시로 다음 화면으로 넘어가도록 설정,
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainAccount()));
                      }); // refreshQrData() 실행 완료 후에 QrImageView 표시
                    },
                    child: const Text(
                      '앱 시작하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(screenWidth * 0.85, screenHeight * 0.08),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF4B4A48),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
