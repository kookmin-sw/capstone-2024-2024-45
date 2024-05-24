import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> tokenReissuePost({required String accessToken, required String refreshToken}) async {

  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/auth-service/api/v2/auth/reissue';

  try {
    http.Response response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode({
          "accessToken" : accessToken,
          "refreshToken" : refreshToken
        }),
        headers: {
          "Content-Type": "application/json",
        });

    print("-----------reissue 보낸 accessToken....------------");
    print(jsonEncode({"accessToken":accessToken}));
    print("-----------reissue 보낸 refreshToken....------------");
    print(jsonEncode({"refreshToken":refreshToken}));

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;

      print("-----------응답....------------");
      print(resBody);
      return resBody;
    } catch (e) {
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}
