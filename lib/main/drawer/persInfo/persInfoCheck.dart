import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suntown/utils/api/user/userProfileGet.dart';

import '../../../utils/screenSizeUtil.dart';
import '../../alert/apiFail/ApiRequestFailAlert.dart';
import '../../../User/userData/User.dart';

class PersInfo extends StatefulWidget {
  @override
  State<PersInfo> createState() => _PersInfoState();
}

class _PersInfoState extends State<PersInfo> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String nickName = 'Loading...';
  String gender = 'Loading...';
  String address = 'Loading...';
  String ageRange = 'Loading...';
  String birth = 'Loading...';
  String profileImage = '';
  User user = User();
  bool dataload = false;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  // user profile 불러오기
  Future<void> fetchProfileData() async {
    final accessToken = await secureStorage.read(key: 'kakaoToken');
    final userId = await secureStorage.read(key: 'userId');
    try {
      final value = await userProfileGet(userId: userId.toString(), accessToken: accessToken.toString());
      setState(() {
        user.initializeData(value["data"]);
        dataload = true;
        nickName = user.nickName;
        address = user.address;
        gender = user.gender;
        ageRange = user.ageRange;
        birth = user.birth;
        profileImage = user.profileImage;
      });
    } catch (e) {
      ApiRequestFailAlert.showExpiredCodeDialog(context, PersInfo());
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
          child: dataload ? buildProfileInfo(screenHeight, screenWidth) : CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildProfileInfo(double screenHeight, double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : AssetImage('assets/images/default_profile.jpeg') as ImageProvider,
                  radius: 50, // 원의 반지름 설정
                ),
                SizedBox(height: screenHeight * 0.024),
                buildInfoRow('별명', nickName, screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.024),
                buildInfoRow('성별', gender, screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.024),
                buildInfoRow('주소', address, screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.024),
                buildInfoRow('생년월일', birth, screenWidth, screenHeight),
              ],
            ),
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
    );
  }

  Widget buildInfoRow(String label, String value, double screenWidth, double screenHeight) {
    return Container(
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
                label,
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
                value,
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
    );
  }
}
