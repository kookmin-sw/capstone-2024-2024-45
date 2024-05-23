import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> logoutAuthPost({required String token, required String userId}) async {

  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/auth-service/api/v2/logOut';

  try {
    http.Response response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode({
          "Authorization" : token,
          "userId" : userId
        }),
        headers: {
          "Content-Type": "application/json",
        });

    print("-----------logOut 보낸 token....------------");
    print(jsonEncode({"token":token}));
    print("-----------logOut 보낸 userId....------------");
    print(jsonEncode({"userId":userId}));

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
