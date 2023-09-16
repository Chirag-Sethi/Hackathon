// To parse this JSON data, do
//
//     final organizationModel = organizationModelFromJson(jsonString);

import 'dart:convert';

OrganizationModel organizationModelFromJson(String str) => OrganizationModel.fromJson(json.decode(str));

String organizationModelToJson(OrganizationModel data) => json.encode(data.toJson());

class OrganizationModel {
    final bool? error;
    final String? message;
    final List<Datum>? data;

    OrganizationModel({
        this.error,
        this.message,
        this.data,
    });

    factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final String? id;
    final String? name;
    final String? description;
    final String? type;
    final String? website;
    final String? mobile;
    final String? email;
    final String? address;
    final String? city;
    final String? state;
    final int? pincode;
    final String? thumbnail;
    final String? createdAt;
    final String? updatedAt;
    final int? v;

    Datum({
        this.id,
        this.name,
        this.description,
        this.type,
        this.website,
        this.mobile,
        this.email,
        this.address,
        this.city,
        this.state,
        this.pincode,
        this.thumbnail,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        website: json["website"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        thumbnail: json["thumbnail"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "type": type,
        "website": website,
        "mobile": mobile,
        "email": email,
        "address": address,
        "city": city,
        "state": state,
        "pincode": pincode,
        "thumbnail": thumbnail,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}
