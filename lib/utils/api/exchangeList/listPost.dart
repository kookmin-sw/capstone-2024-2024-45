import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


/*
type : ALL, SEND, RECEIVE
 */
Future<Map<String, dynamic>> listPost(String type, String accountId) async {
  String baseUrl = 'http://223.130.141.109:8000/api/exchange/remittance/history';

  try {
    http.Response response = await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "type": type,
      "accountId": accountId
    }), headers: {
      "Content-Type": "application/json",
      "accept": "*/*",
    });

    try {
      final Map<String, dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));
      final statusCode = response.statusCode;

      if (responseJson.containsKey('data')) {
        final List<dynamic> dataList = responseJson['data'];
        final Map<String, dynamic> resBody = {
          'statusCode': statusCode,
          'data': dataList,
        };

        return resBody;
      } else {
        return {'statusCode': statusCode, 'data': []};
      }
    } catch (e) {
      debugPrint("Error decoding response: $e");
      return {'statusCode': 490, 'data': []};
    }

  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}