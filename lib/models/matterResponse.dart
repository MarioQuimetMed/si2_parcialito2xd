// To parse this JSON data, do
//
//     final matterResponse = matterResponseFromJson(jsonString);

import 'dart:convert';

MatterResponse matterResponseFromJson(String str) =>
    MatterResponse.fromJson(json.decode(str));

String matterResponseToJson(MatterResponse data) => json.encode(data.toJson());

class MatterResponse {
  int statusCode;
  String message;
  Data data;

  MatterResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MatterResponse.fromJson(Map<String, dynamic> json) => MatterResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<DetailWork> detailWorks;

  Data({
    required this.detailWorks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        detailWorks: List<DetailWork>.from(
            json["detailWorks"].map((x) => DetailWork.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detailWorks": List<dynamic>.from(detailWorks.map((x) => x.toJson())),
      };
}

class DetailWork {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  Workload workload;
  Matter matter;
  Group group;

  DetailWork({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.workload,
    required this.matter,
    required this.group,
  });

  factory DetailWork.fromJson(Map<String, dynamic> json) => DetailWork(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        workload: Workload.fromJson(json["workload"]),
        matter: Matter.fromJson(json["matter"]),
        group: Group.fromJson(json["group"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "workload": workload.toJson(),
        "matter": matter.toJson(),
        "group": group.toJson(),
      };
}

class Group {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String? name;
  bool? status;
  String? description;

  Group({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.name,
    this.status,
    this.description,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        name: json["name"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "name": name,
        "status": status,
        "description": description,
      };
}

class Matter {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String code;
  String name;
  bool status;
  Group career;

  Matter({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.code,
    required this.name,
    required this.status,
    required this.career,
  });

  factory Matter.fromJson(Map<String, dynamic> json) => Matter(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        code: json["code"],
        name: json["name"],
        status: json["status"],
        career: Group.fromJson(json["career"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "code": code,
        "name": name,
        "status": status,
        "career": career.toJson(),
      };
}

class Workload {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  User user;
  Period period;

  Workload({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.user,
    required this.period,
  });

  factory Workload.fromJson(Map<String, dynamic> json) => Workload(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        user: User.fromJson(json["user"]),
        period: Period.fromJson(json["period"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "user": user.toJson(),
        "period": period.toJson(),
      };
}

class Period {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;
  Group typePeriod;
  Group management;
  bool status;

  Period({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.typePeriod,
    required this.management,
    required this.status,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        name: json["name"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        typePeriod: Group.fromJson(json["typePeriod"]),
        management: Group.fromJson(json["management"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "name": name,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "typePeriod": typePeriod.toJson(),
        "management": management.toJson(),
        "status": status,
      };
}

class User {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String name;
  String email;
  String password;
  String phone;
  bool status;
  String tokenFmc;
  List<Role> roles;

  User({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.status,
    required this.tokenFmc,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        status: json["status"],
        tokenFmc: json["tokenFMC"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "status": status,
        "tokenFMC": tokenFmc,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Role {
  int id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
