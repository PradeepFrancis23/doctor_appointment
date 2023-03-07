class Users {
  String email, password;
// construtuor
  Users(
    this.email,
    this.password,
  );

  //  converter that convert jsondata to object
  Users.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
