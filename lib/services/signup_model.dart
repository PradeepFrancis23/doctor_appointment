import 'dart:convert';

class UserSignupModel {
  String fullname, phonenumber, email, password, confirmpassword;
// construtuor
  UserSignupModel(
    this.fullname,
    this.phonenumber,
    this.email,
    this.password,
    this.confirmpassword,
  );

  //  converter that convert jsondata to object
  UserSignupModel.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        phonenumber = json['phonenumber'],
        email = json['email'],
        password = json['password'],
        confirmpassword = json['confirmpassword'];

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'phonenumber': phonenumber,
        'email': email,
        'password': password,
        'confirmpassword': confirmpassword,
      };
}
