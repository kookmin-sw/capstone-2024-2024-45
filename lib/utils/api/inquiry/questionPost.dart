import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> QuestionPost({required user_id, required memoText, required accessToken}) async {
  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/timebank-admin-service/api/admin/inquiries';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "inquire": memoText,
    }), headers: {
      "Content-Type": "application/json",
      "userId" : user_id.toString(),
      "Authorization": "Bearer $accessToken"
    });

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      print(response.statusCode);
      print('----------');
      print(resBody);
      resBody['statusCode'] = response.statusCode;
      return resBody;

    } catch (e) {
      return {'statusCode': 422};
    }

  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}