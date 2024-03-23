import 'dart:convert';

class RegisterRequestModel {
    final String? name;
    final String? email;
    final String? password;
    final String? phone;

    RegisterRequestModel({
        this.name,
        this.email,
        this.password,
        this.phone,
    });

    factory RegisterRequestModel.fromJson(String str) => RegisterRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterRequestModel.fromMap(Map<String, dynamic> json) => RegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
    };
}
