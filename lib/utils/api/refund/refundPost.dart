import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> refundPost({required transId, required expectedAmount, required inquire}) async {

  String baseUrl = 'http://223.130.154.131:80/api/admin/inquiries/remittance';

  try {
    http.Response response =
    await http.post(Uri.parse(baseUrl), body: jsonEncode({
      "transId" : transId,
      "expectedAmount": expectedAmount,
      "inquire": inquire,
    }), headers: {
      "Content-Type": "application/json",
      "userId" : "1", //임시,
      "accept" : "*/*",
    });

    try {
      Map<String, dynamic> resBody =
      jsonDecode(utf8.decode(response.bodyBytes));

      print('=====');
      print(response.body);
      print(resBody);
      print('-----');
      print(response.statusCode);
      print('=====');

      resBody['statusCode'] = response.statusCode;
      return resBody;

    } catch (e) {
      return {'statusCode': 422};
    }

  } catch (e) {
    debugPrint("httpGet error: $e");
    return {'statusCode': 503};
  }
}