import 'model_base.dart';

class UserModel extends ModelBase {
  String id;
  String name;
  String nickname;
  late String email;

  UserModel({
    required this.id,
    required this.name,
    required this.nickname,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    var user = UserModel(
      id: data["id"],
      name: data["name"],
      nickname: data["nickname"],
    );

    user.email = data["email"];
    
    return user;
  }

  static bool isValidEmailPassword(String email, String password) {
    var isValidPwd = password.isNotEmpty && password.length > 3;

    return _isValidEmail(email) && isValidPwd;
  }

  static bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
