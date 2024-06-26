import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> qrScanPost(
    {required String hmac,
    required String data,
    required String senderAccountId}) async {

  String url = dotenv.env['EXCHANGE_LOCAL_URL']!;
  String baseUrl = '${url}/api/exchange/qr/scan';

  try {
    http.Response response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode({
          "hmac": hmac,
          "userInfo": data,
          "senderAccountId": senderAccountId
        }),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
        });

    print("-----------qr 송금으로 보낸 데이터....------------");
    print(jsonEncode(
        {"hmac": hmac, "userInfo": data, "senderAccountId": senderAccountId}));

    try {
      Map<String, dynamic> resBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;

      print("-----------응답....------------");
      print(resBody);
      return resBody;
    } catch (e) {
      return {'statusCode': 490};
    }
  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}
