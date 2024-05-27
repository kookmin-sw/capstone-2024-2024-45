import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/*
{
  "hmac": "string",
  "remittanceInfo": "<accountNumber>%<password>%<amount>%<receiverAccountNumber>"
}
 */

Future<Map<String, dynamic>> sendPost({required hmac, required remittanceInfo, required userId, required token}) async {

  String url = dotenv.env['AUTH_URL']!;
  String baseUrl = '${url}/timebank-service/api/remittance/qr';

  print("----hmac------");
  print(hmac);

  print("----remittanceInfo------");
  print(remittanceInfo);

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "hmac": hmac,
      "remittanceInfo": remittanceInfo,
    }), headers: {
      "Content-Type": "application/json",
      "userId" : userId, //예시 userId
      "Authorization": "Bearer $token",
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