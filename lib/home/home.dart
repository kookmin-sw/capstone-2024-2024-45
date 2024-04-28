import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suntown/main/mainAccount.dart';

import '../permission/permissionWidget.dart';
import '../utils/screenSizeUtil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final page = const MainAccount();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      checkPermissionsAndNavigate();
    });
  }

  Future<void> checkPermissionsAndNavigate() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;

    if (cameraPermissionStatus.isGranted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainAccount()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PermissionWidget()));
    }
  }

  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffFFFBD3),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.3, // Lottie와 텍스트 간격 조절
          ),
          Center(
            child: Lottie.asset(
              "assets/lottie/house.json",
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '매듭 ',
                    style: TextStyle(
                      color: Color(0xFFFF8D4D),
                      fontSize: screenWidth * 0.15,
                      fontFamily: 'Cafe24 Supermagic OTF',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '창고\n',
                    style: TextStyle(
                      color: Color(0xFF4B4A48),
                      fontSize: screenWidth * 0.15,
                      fontFamily: 'Cafe24 Supermagic OTF',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
