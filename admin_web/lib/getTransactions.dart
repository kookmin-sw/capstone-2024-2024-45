
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getTransactions({required String type, required bool completion}) async {
  final apiUrl = dotenv.env['ADMIN_LOCAL_SERVER'];
  String baseUrl = '${apiUrl}/timebank-admin-service/api/admin/inquiries';

  try {
    http.Response response = await http.get(Uri.parse(baseUrl).replace(queryParameters: {
    'type': type,
    'completion': completion.toString()}), headers: {
      "accept": "*/*", // 명확하게 JSON을 수락한다는 것을 표시
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