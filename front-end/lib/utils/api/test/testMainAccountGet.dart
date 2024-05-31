import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


/*
mainAccount 화면 사용 용도
나중에 LIST 조회 되는 것 확인하고 PUSH할 예정
 */

Future<Map<String, dynamic>> testMainAccountGet(String userId) async {
  String baseUrl = 'http://223.130.133.30:8000/api/user/${userId}/account';

  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
    });

    try {
      final Map<String, dynamic> responseJson = json.decode(utf8.decode(response.bodyBytes));
      final statusCode = response.statusCode;

      if (responseJson.containsKey('result')) {
        final dynamic result = responseJson['result'];

        if (result["account_id_list"] is List) {
          final List<dynamic> dataList = result["account_id_list"];
          final Map<String, dynamic> resBody = {
            'statusCode': statusCode,
            'data': dataList,
          };
          return resBody;
        } else {
          // 'result' 키의 값이 리스트가 아닌 경우에 대한 처리
          return {'statusCode': statusCode, 'data': []};
        }
      } else {
        // 'result' 키가 없는 경우에 대한 처리
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