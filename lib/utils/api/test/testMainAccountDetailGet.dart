
//account 정보 조회
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> testMainAccountDetailGet(String accountId) async {
  String baseUrl = 'http://223.130.133.30:8080/api/accounts/${accountId}/info';

  try {
    http.Response response =
    await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
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