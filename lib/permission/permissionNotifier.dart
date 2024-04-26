import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main/alert/permissoinDenied.dart';

class PermissionNotifier with ChangeNotifier {
  bool _isPermissionGranted = false;
  bool get isPermissionGranted => _isPermissionGranted;

  void updatePermissionStatus(bool isGranted) {
    _isPermissionGranted = isGranted;
    notifyListeners(); // 상태 변경을 구독자에게 알림
  }

  Future<void> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.request();
    updatePermissionStatus(status.isGranted);
    if (!status.isGranted) {
      _showCustomAlertDialog(context);
    }
  }

  void _showCustomAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    );
  }

  // 권한 상태를 확인하고 업데이트하는 메서드
  Future<void> checkAndUpdatePermissionStatusFromSettings() async {
    PermissionStatus status = await Permission.camera.status;
    updatePermissionStatus(status.isGranted);
  }
}

