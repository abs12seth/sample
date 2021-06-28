class Hospital{
  String name;
  String phone_no;
  String email;
  String password;
  String hospital_id;
  int beds;
  int doctors;
  String city;

  Hospital(
  {
    this.name,
    this.phone_no,
    this.email,
    this.password,
    this.hospital_id,
    this.beds,
    this.doctors,
    this.city,
  });

  Hospital.fromMap(dynamic obj) {
    this.name = obj['name'];
    this.phone_no = obj['phone_no'];
    this.email = obj['email'];
    this.password = obj['password'];
    this.hospital_id = obj['hospital_id'];
    this.beds = obj['beds'];
    this.doctors = obj['doctors'];
    this.city = obj['city'];
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
      'city': city,
    };
  }

  @override
  String toString(){
    return 'Hospital{name: $name,phone_no: $phone_no,email: $email, password: $password, hospital_id: $hospital_id, beds: $beds, doctors: $doctors, city: $city}';
  }

}