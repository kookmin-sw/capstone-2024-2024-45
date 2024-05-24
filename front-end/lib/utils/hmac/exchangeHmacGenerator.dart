

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HmacGenerator {
  late final String APP_EXCHANGE_KEY;
  final Hash algorithm = sha256;

  Future<void> _initialize() async {
    DotEnv dotenv = DotEnv();
    // load 메서드 호출
    await dotenv.load();
    APP_EXCHANGE_KEY = await dotenv.get("APP_EXCHANGE_KEY") ?? '';

    print("-----------app 키 확인---------------");
    print(APP_EXCHANGE_KEY);
  }

   // 사용할 해시 알고리즘
  static String generateHmac(String key, String message, Hash algorithm) {
    var hmac = Hmac(algorithm as Hash, utf8.encode(key));
    var digest = hmac.convert(utf8.encode(message));

    //HexString(16진수)로 변환
    String hexDigest = digest.bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

    print("-----------hexDigest 키 확인---------------");
    print(hexDigest);

    return hexDigest;
  }

  Future<String> generateHmacAsync(String sendAccountId, String receiverAccountId, int amount) async {
    await _initialize();
    String data = makeEncodingData(sendAccountId, receiverAccountId, amount);
    return generateHmac(APP_EXCHANGE_KEY, data, algorithm);
  }

  //데이터 받아서 encodingData로 변환하기 위한 함수
  //구분자는 똑같이 %로 맞춤
  String makeEncodingData(String sendAccountId, String receiverAccountId, int amount){
    String data = sendAccountId + "%" + receiverAccountId + "%" + amount.toString();

    print("-----------data 확인---------------");
    print(data);

    return data;
  }

}