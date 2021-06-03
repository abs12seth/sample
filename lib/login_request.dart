
import 'package:co_win/databaseapp.dart';
import 'package:co_win/users.dart';

class LoginRequest {
  LoginApp con = new LoginApp();
  Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}