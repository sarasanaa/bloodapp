class UserModel {
  String? uid;
  String? email;
  String? Name;
  String? phone;
  String? age;
  String? blood;
  String? place;

  UserModel(
      {this.uid,
      this.email,
      this.Name,
      this.phone,
      this.age,
      this.blood,
      this.place});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['البريد الالكتروني'],
      Name: map['اسم المتبرع'],
      phone: map['رقم الهاتف'],
      age: map['العمر'],
      blood: map['زمرة الدم'],
      place: map['البلدية'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'البريد الالكتروني': email,
      'اسم المتبرع': Name,
      'رقم الهاتف': phone,
      'العمر': age,
      'زمرة الدم': blood,
      'البلدية': place,
    };
  }
}
