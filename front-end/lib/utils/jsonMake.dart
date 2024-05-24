class JsonUtils {
  static Map<String, dynamic> createJsonData(
      Map<String, dynamic> baseData, String amount) {
    // 새로운 JSON 데이터를 생성하고 amount 값을 추가
    Map<String, dynamic> newData = {
      ...baseData, // 기존 데이터 복사
      'amount': amount,
    };
    return newData;
  }
}