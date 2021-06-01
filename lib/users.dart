
class User {
  String name;
  String user_name;
  String phone_no;
  String email;
  String password;

  User(
      {this.name,
      this.user_name,
      this.phone_no,
      this.email,
      this.password,});
  User.fromMap(dynamic obj){
    this.name = obj['name'];
    this.user_name = obj['username'];
    this.phone_no = obj['mobile'];
    this.email = obj['email'];
    this.password = obj['password'];
  }

  String get _name => name;
  String get _username => user_name;
  String get _mobile => phone_no;
  String get _email => email;
  String get _password => password;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
      map['name'] =  name;
      map['user_name'] =  user_name;
      map['phone_no'] = phone_no;
      map['email'] = email;
      map['password'] = password;
      return map;
  }

  @override
  String toString() {
    return 'User{name: $name,user_name: $user_name,phone_no: $phone_no,email: $email, password: $password}';
  }
}
