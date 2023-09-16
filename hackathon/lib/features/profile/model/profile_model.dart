// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    final bool? error;
    final String? message;
    final Data? data;

    ProfileModel({
        this.error,
        this.message,
        this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final String? id;
    final String? name;
    final String? password;
    final String? email;
    final String? mobile;
    final String? createdAt;
    final String? updatedAt;
    final int? v;
    final String? address;
    final String? city;
    final int? pincode;
    final String? state;

    Data({
        this.id,
        this.name,
        this.password,
        this.email,
        this.mobile,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.address,
        this.city,
        this.pincode,
        this.state,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
        mobile: json["mobile"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        address: json["address"],
        city: json["city"],
        pincode: json["pincode"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "email": email,
        "mobile": mobile,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "address": address,
        "city": city,
        "pincode": pincode,
        "state": state,
    };
}
