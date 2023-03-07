import 'dart:convert';

class UserSignupModel {
  String fullname, phonenumber, email, password, confirmpassword;
// construtuor
  UserSignupModel(
    this.fullname,
    this.phonenumber,
    this.confirmpassword,
    this.email,
    this.password,
  );

  //  converter that convert jsondata to object
  UserSignupModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'],
        fullname = json['fullname'],
        phonenumber = json['phonenumber'],
        confirmpassword = json['confirmpassword'];

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'phonenumber': phonenumber,
        'confirmpassword': confirmpassword,
        'email': email,
        'password': password,
      };
}
