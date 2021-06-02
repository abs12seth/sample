import 'package:co_win/database.dart';
import 'package:co_win/users.dart';

class LoginRequest {
  Login con = new Login();
  Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}