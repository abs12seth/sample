class Hospital{
  String name;
  String phone_no;
  String email;
  String password;
  String hospital_id;
  int beds;
  int doctors;

  Hospital(
  {
    this.name,
    this.phone_no,
    this.email,
    this.password,
    this.hospital_id,
    this.beds,
    this.doctors,
  });

  Hospital.fromMap(dynamic obj) {
    this.name = obj['name'];
    this.phone_no = obj['phone_no'];
    this.email = obj['email'];
    this.password = obj['password'];
    this.hospital_id = obj['hospital_id'];
    this.beds = obj['beds'];
    this.doctors = obj['doctors'];
  }

  Map<String, dynamic> toMap() {
    return{
      'name': name,
      'phone_no': phone_no,
      'email':email,
      'password': password,
      'hospital_id': hospital_id,
      'beds': beds,
      'doctors': doctors,
    };
  }

  @override
  String toString(){
    return 'Hospital{name: $name,phone_no: $phone_no,email: $email, password: $password, hospital_id: $hospital_id, beds: $beds, doctors: $doctors}';
  }

}