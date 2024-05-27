
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getTransactions() async {
  String baseUrl = 'https://reqres.in';
  try {
    final response = await http.get(Uri.parse('$baseUrl/api/users?page=2'));
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