import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/*
type : ALL, SEND, RECEIVE
 */
Future<Map<String, dynamic>> listPost(String type, String accountId, String token) async {

  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/timebank-service/api/remittance/history';

  try {
    Uri uri = Uri.parse(baseUrl).replace(queryParameters: {
      'type': type,
    });

    http.Response response = await http.post(
      uri,
      body: jsonEncode({
        "accountId": accountId,
      }),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "accept": "*/*",
      },
    );

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