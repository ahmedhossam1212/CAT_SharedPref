class User {
  final String name;
  final String email;
  final String phone;
  User(this.name, this.email,this.phone);
  //constructor that convert json to object instance
  User.fromJson(Map<String, dynamic> json) : name = json['name'],  email = json['email'],phone = json['phone'];
  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone':phone
  };
}
