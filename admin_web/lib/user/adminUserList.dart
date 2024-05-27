
/*
연동 리스트

{
  "id": 7,
  "email": "michael.lawson@reqres.in",
  "first_name": "Michael",
  "last_name": "Lawson",
  "avatar": "https://reqres.in/img/faces/7-image.jpg"
},
 */

class AdminUserList {
  late int id;
  late String email;
  late String first_name;
  late String last_name;
  late String avatar;
  late String createdAtToDaily;

  AdminUserList({required this.id, required this.email, required this.first_name, required this.last_name, required this.avatar});

  // // 기본 이미지 URL 설정
  // static const String defaultProfileImg = 'assets/images/nullProfile.jpg';

  AdminUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    first_name = json['first_name'] ?? '';
    last_name = json['last_name']?? '';
    avatar = json['avatar'];
  }
}