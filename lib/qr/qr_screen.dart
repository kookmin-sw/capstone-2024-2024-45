import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/http_request.dart';

class qr_screen extends StatefulWidget {
  const qr_screen({super.key});

  @override
  State<qr_screen> createState() => _qr_screenState();
}

Map<String, dynamic>? apiResult;

class _qr_screenState extends State<qr_screen> {
  Future<dynamic> fetchData() async {
    try {
      final value = await httpGet(path: '/api/users?page=2');
      if (value["statusCode"] == 200) {
        debugPrint("${value['data'][0]}");
        return value['data'][0];
      } else {
        debugPrint('서버 에러입니다. 다시 시도해주세요');
        return null; //alert 추가 필요
      }
    } catch (e) {
      debugPrint('API 요청 중 오류가 발생했습니다: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String data;

    return Scaffold(
      backgroundColor: Color(0xFFFFF6F6),
      appBar: AppBar(
        title: Text("flutter_qr"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("매듭을 받습니다!",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text: '내 ',
                        style: TextStyle(fontSize: 25, color: Color(0xFFFF8D4D), fontFamily: 'Noto Sans KR'),
                        children: <TextSpan>[
                          TextSpan(
                            text: '"매듭코드"',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '를',
                          ),
                        ],
                      ),
                    ),
                    Text("매듭을 받을 이웃에게 보여주세요!",
                      style: TextStyle(fontSize: 25,
                        color: Color(0xFFFF8D4D),
                        fontFamily: 'Noto Sans KR',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(color: Color(0xFFFFE2E2)),
                child: Center(
                  child: FutureBuilder<dynamic>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); //로딩
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          if (snapshot.data == null) {
                            data = "null"; //여기는 null 들어올 경우 화면 처리가 필요할 것 같은데, 일단은 보류
                          } else {
                            data = jsonEncode(snapshot.data);
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 306,
                                height: 62,
                                decoration: BoxDecoration(color: Color(0xFFFFF6F6)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snapshot.data["last_name"]}의 매듭 코드",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              QrImageView(
                                data: data,
                                // JSON 데이터를 문자열로 변환하여 전달
                                embeddedImage:
                                    NetworkImage(snapshot.data["avatar"] as String),
                                // 네트워크 이미지 포함
                                embeddedImageStyle: QrEmbeddedImageStyle(
                                  size: Size(50, 50), // 내장된 이미지의 크기
                                ),
                                version: QrVersions.auto,
                                size: 300,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
