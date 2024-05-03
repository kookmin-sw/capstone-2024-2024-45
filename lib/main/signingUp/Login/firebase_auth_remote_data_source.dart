import 'package:http/http.dart' as http;
class FirebaseAuthRemoteDataSource {
  //server url
  final String url = ' https://us-central1-kepstone-9eb20.cloudfunctions.net/createCustomToken';

  // 유저정보를 전달하면 서버랑 통신해서 토큰을 만들어주는 메서드
  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final customTokenResponse =
    await http.post(Uri.parse(url), body: user);
    // body로 token을 보냄
    return customTokenResponse.body;
    // final responseJson = jsonDecode(customTokenResponse.body);
    // print('Received Token from server: ${responseJson['firebaseToken']}');
    //
    // return responseJson['firebaseToken'];
  }
}
