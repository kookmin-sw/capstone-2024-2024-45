import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                      side: BorderSide(width: 1, color: Color(0xFFF9DEDE)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\u{1F4F7} 카메라",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Text(
                        '“매듭 코드” 송금을 진행 하려면,\n매듭 코드를 카메라로 스캔해야 합니다.\n이를 위해 카메라 권한이 필요합니다.',
                        style: TextStyle(
                          color: Colors.black,
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
                  height: 10,
                ),
                Text(
                  '\u{26A0} 권한 허용 후, 매듭 창고를 시작합니다.\n아래 “권한 설정하기” 버튼을 눌러서\n권한을 허용해주세요',
                  style: TextStyle(
                    color: Color(0xFF727272),
                    fontSize: 17,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  textAlign: TextAlign.left, // 텍스트를 왼쪽으로 정렬
                ),
                SizedBox(
                  height: 20,
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
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF4B4A48),
                  ),
                )
                    : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainAccount()));
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
                    fixedSize: Size(screenWidth * 0.85, screenHeight * 0.08),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF4B4A48),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
