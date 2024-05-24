import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> logoutAuthPost({required String token, required String userId}) async {
  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '$url/auth-service/api/v2/logOut';

  try {
    http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "userId": userId
      },
    );
    print("-----------logOut 보낸 token....------------");
    print(jsonEncode({"token": token}));
    print("-----------logOut 보낸 userId....------------");
    print(jsonEncode({"userId": userId}));
    try {
      Map<String, dynamic> resBody = jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;

      print("-----------응답....------------");
      print(resBody);
      return resBody;
    } catch (e) {
      print("JSON parsing error: $e");
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpPost error: $e");
    return {'statusCode': 503};
  }
}
