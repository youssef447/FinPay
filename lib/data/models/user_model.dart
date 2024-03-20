class UserModel {
  late String fullName;
  late String? username;
  late int id, testMode;
  late String email;
  late String? phone;
  late String? birthdate;
  late String profilePicUrl;
  late String token, registrationTime;
  late int pinCodeRequired, notificationOn;

  late final String? dialCode, isoCode;

  late bool verifiedEmail, verifiedPhone;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    fullName = json["full_name"];
    username = json["user_name"];
    email = json["email"];
    phone = json["phone"];
    registrationTime = json["registration_Time"];
    testMode = json['test_mode'];
    birthdate = json["birthdate"];
    profilePicUrl = json["picture"];
    verifiedEmail = json["verified_email"];
    pinCodeRequired = json['pincode_require'];
    notificationOn = json['notifications_on_off'];
    token = json['token'];
  }

  toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'user_name': username,
      'email': email,
      'phone': phone,
      'test_mode': testMode,
      'birthdate': birthdate,
      'picture': profilePicUrl,
      'verified_email': verifiedEmail,
      'notifications_on_off': notificationOn,
      'pincode_require': pinCodeRequired,
      'registration_Time': registrationTime,
      'token': token,
    };
  }
}
