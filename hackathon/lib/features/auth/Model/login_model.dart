class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.userData,
    this.accessToken,
    this.refreshToken,
  });

  int? status;
  String? message;
  UserData? userData;
  String? accessToken;
  String? refreshToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        userData: json["user_data"] == null
            ? null
            : UserData.fromJson(json["user_data"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_data": userData?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}

class UserData {
  UserData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.phone,
      this.userName,
      this.password,
      this.teacherId,
      this.isActive,
      this.type,
      this.userBoard,
      this.userLanguage,
      this.userDataClass,
      this.userStream,
      this.school,
      this.schoolUuid,
      this.stateUuid});

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  String? userName;
  String? password;
  String? teacherId;
  String? stateUuid;

  bool? isActive;
  String? schoolUuid;
  Type? type;
  Class? userBoard;
  Class? userLanguage;
  Class? userDataClass;
  Class? userStream;
  School? school;

  void fromModel(UserData userData) {
    firstName = userData.firstName;
    lastName = userData.lastName;
    id = userData.id;
    email = userData.email;
    countryCode = userData.countryCode;
    type = userData.type;
    userName = userData.userName;
    phone = userData.phone;
    teacherId = userData.teacherId;
    userBoard = userData.userBoard;
    userDataClass = userData.userDataClass;
    userLanguage = userData.userLanguage;
    userStream = userData.userStream;
    school = userData.school;
    schoolUuid = userData.schoolUuid;
    stateUuid = userData.stateUuid;
  }

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        school: json['school'] != null ? School.fromJson(json['school']) : null,
        schoolUuid: json['school_uuid'],
        lastName: json["last_name"],
        email: json["email"],
        countryCode: json["country_code"],
        phone: json["phone"],
        userName: json["user_name"],
        teacherId: json["teacher_id"],
        stateUuid: json["state_uuid"],
        isActive: json["is_active"],
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        userBoard: json["user_board"] == null
            ? null
            : Class.fromJson(json["user_board"]),
        userLanguage: json["user_language"] == null
            ? null
            : Class.fromJson(json["user_language"]),
        userDataClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
        userStream: json["user_stream"] == null
            ? null
            : Class.fromJson(json["user_stream"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "user_name": userName,
        "teacher_id": teacherId,
        "is_active": isActive,
        "type": type?.toJson(),
        "user_board": userBoard?.toJson(),
        "user_language": userLanguage?.toJson(),
        "class": userDataClass?.toJson(),
        "user_stream": userStream?.toJson(),
      };
}

class Type {
  Type({
    this.id,
    this.type,
  });

  String? id;
  String? type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}

class Class {
  Class({
    this.id,
    this.classClass,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.code,
  });

  final String? id;
  final int? classClass;
  final String? slug;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? code;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"] ?? "",
        classClass: json["class"] ?? 0,
        slug: json["slug"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"] ?? "",
        code: json["code"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class": classClass,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "code": code,
      };
}

class School {
  School({
    this.id,
    this.schoolName,
    this.schoolId,
    this.schoolAddress,
    this.district,
    this.state,
    this.language,
    this.board,
    this.boardId,
  });

  String? id;
  String? schoolName;
  String? schoolId;
  String? schoolAddress;
  String? district;
  String? state;
  String? language;
  String? board;
  String? boardId;

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        schoolName: json["school_name"],
        schoolId: json["school_id"],
        schoolAddress: json["school_address"],
        district: json["district"],
        state: json["state"],
        language: json["language"],
        board: json["board"],
        boardId: json["board_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_name": schoolName,
        "school_id": schoolId,
        "school_address": schoolAddress,
        "district": district,
        "state": state,
        "language": language,
        "board": board,
        "board_id": boardId,
      };
}
