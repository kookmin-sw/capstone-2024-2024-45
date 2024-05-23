import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginAuthPost({required String token,}) async {

  //String url = dotenv.env['AUTH_URL']!;${url}
  String baseUrl = 'http://175.45.203.201:8081/auth-service/api/v2/auth/signin/kakao';

  try {
    http.Response response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode({
          "token": token,
        }),
        headers: {
          "Content-Type": "application/json",
        });

    print("-----------login 보낸 token....------------");
    print(jsonEncode({"token":token}));

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
