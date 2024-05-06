import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendPost({required senderAccountId, required amount, required receiverAccountId}) async {

  String baseUrl = 'http://223.130.141.109:8000/api/exchange/remittance/qr';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "senderAccountId": senderAccountId,
      "amount": amount,
      "receiverAccountId": receiverAccountId
    }), headers: {
      "Content-Type": "application/json",
      "userId" : "1", //예시 userId
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