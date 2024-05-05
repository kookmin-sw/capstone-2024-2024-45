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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainAccount()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PermissionWidget()));
    }
  }

  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeUtil.screenHeight(context);
    double screenWidth = ScreenSizeUtil.screenWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffFFFDF3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(children: [
            SizedBox(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              child: Image(
                image: AssetImage('assets/images/knotWarehouse.png'),
              ),
            ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
          ])),
        ],
      ),
    );
  }
}
