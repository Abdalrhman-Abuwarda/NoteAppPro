class Student {
  final int id;
  final String fullName;
  final String email;
  final String gender;
  final String? fcmToken;
  final String token;
  final String refreshToken;
  final bool isActive;

  Student(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.gender,
      required this.fcmToken,
      required this.token,
      required this.refreshToken,
      required this.isActive});

  // Student();
  // Student.obj(this.fullName, this.password, this.email,this.gender);
  // Student.obj(this.fullName, this.password, this.email,this.gender);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        gender: json["gender"],
        fcmToken: json["fcm_token"],
        token: json["token"],
        refreshToken: json["refresh_token"],
        isActive: json["is_active"]);

  }

  // Student.obj(this.fullName, this.email, this.gender, this.password);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['gender'] = gender;
    data['fcm_token'] = fcmToken;
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    data['is_active'] = isActive;
    return data;
  }
}
