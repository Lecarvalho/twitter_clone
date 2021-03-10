import 'model_base.dart';

class UserModel extends ModelBase {
  String uid;
  String email;
  String displayName;
  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  static bool checkFields(String _email, String _password, String _name){
    return _name.isNotEmpty && isValidEmailPassword(_email, _password);
  }

  static bool isValidEmailPassword(String _email, String _password) {
    var isValidPwd = _password.isNotEmpty && _password.length > 3;

    return _isValidEmail(_email) && isValidPwd;
  }

  static bool _isValidEmail(String _email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
  }
}
