import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> qrPost(String accountId, String userId) async {

  String url = dotenv.env['EXCHANGE_LOCAL_URL']!;
  String baseUrl = '${url}/api/exchange/qr/create';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "accountId": accountId
    }), headers: {
      "Content-Type": "application/json",
      "userId" : userId, //예시 userId
    });

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;

      print("----------------qr에 들어간 정보-----------------");
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