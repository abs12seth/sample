
class User {
  String name;
  String phone_no;
  String email;
  String password;

  User(
      {this.name,
      this.phone_no,
      this.email,
      this.password,});
  User.fromMap(dynamic obj){
    this.name = obj['name'];
    this.phone_no = obj['mobile'];
    this.email = obj['email'];
    this.password = obj['password'];
  }

  String get _name => name;
  String get _mobile => phone_no;
  String get _email => email;
  String get _password => password;


  Map<String, dynamic> toMap() {
    print(phone_no);
    return {
      'name': name,
      'phone_no':phone_no,
      'email':email,
      'password':password,
    };
  }

  @override
  String toString() {
    return 'User{name: $name,user_name: $user_name,phone_no: $phone_no,email: $email, password: $password}';
  }
}
