import 'dart:convert';
import 'package:http/http.dart' as http;

//일단 이렇게 완료.

/*
여기서 리스트를 저장해야함
 */

class ApiService {
  static const String baseUrl = 'https://reqres.in';

  Future<List<dynamic>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/api/users?page=2'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['data'];  // 'data' 필드의 리스트를 반환
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<void> updateTransaction(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/transaction/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction');
    }
  }
  //
  // Future<void> cancelTransaction(int id) async {
  //   final response = await http.delete(Uri.parse('$baseUrl/transaction/$id'));
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to cancel transaction');
  //   }
  // }
}
