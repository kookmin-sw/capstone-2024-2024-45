import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> qrScanPost({required String hmac, required String data}) async {

  String baseUrl = 'http://223.130.141.109:8000/api/exchange/qr/scan';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "hmac": hmac,
      "userInfo": data,
      "senderAccountId": "11111111-1111-1111-111111111111" //나중에 user 연결 되면 변경
    }), headers: {
      "Content-Type": "application/json",
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