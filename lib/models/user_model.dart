import 'model_base.dart';

class UserModel extends ModelBase {
  late String id;
  String name;
  String? email;
  String nickname;

  UserModel({
    required this.name,
    required this.email,
    required this.nickname,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    var user = UserModel(
      name: data["name"],
      email: data["email"],
      nickname: data["nickname"],
    );

    user.id = data["id"];
    
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
