
//account 정보 조회
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> testMainAccountDetailGet(String userId) async {
  String url = dotenv.env['EXCHANGE_LOCAL_URL']!;
  String baseUrl = '${url}/timebank-service/api/account';

  print("-----------------baseUrl------------------");
  print(baseUrl);

  try {
    http.Response response =
    await http.get(Uri.parse(baseUrl), headers: {
      "accept": "*/*",
      'Content-Type': 'application/json',
      "userId": userId
    });

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));

      resBody['statusCode'] = response.statusCode;
      return resBody;

    } catch (e) {
      return {'statusCode': 490};
    }

  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}