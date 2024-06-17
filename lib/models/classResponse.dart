// To parse this JSON data, do
//
//     final classResponse = classResponseFromJson(jsonString);

import 'dart:convert';

import 'package:si2_parcialito2/models/materia.dart';

ClassResponse classResponseFromJson(String str) =>
    ClassResponse.fromJson(json.decode(str));

String classResponseToJson(ClassResponse data) => json.encode(data.toJson());

class ClassResponse {
  int statusCode;
  String message;
  Data data;

  ClassResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  static List<MateriaDia> getClasses(ClassResponse classResponse) {
    List<MateriaDia> materias = [];
    classResponse.data.assists.forEach((assist) {
      MateriaDia materia = MateriaDia(
        id: assist.id,
        nombre: assist.detailClass.detailWork.matter.name,
        moduloAula:
            "${assist.detailClass.classroom.nro} - ${assist.detailClass.classroom.module?.nro}",
        horario:
            "${assist.detailClass.startTime} - ${assist.detailClass.endTime}",
        dias: [assist.detailClass.day],
        grupo: assist.detailClass.detailWork.group.name,
      );
      materias.add(materia);
    });
    return materias;
  }

  factory ClassResponse.fromJson(Map<String, dynamic> json) => ClassResponse(
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
  List<Assist> assists;

  Data({
    required this.assists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        assists:
            List<Assist>.from(json["assists"].map((x) => Assist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assists": List<dynamic>.from(assists.map((x) => x.toJson())),
      };
}

class Assist {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  DateTime time;
  String assistsStatus;
  DetailClass detailClass;

  Assist({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.time,
    required this.assistsStatus,
    required this.detailClass,
  });

  factory Assist.fromJson(Map<String, dynamic> json) => Assist(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        time: DateTime.parse(json["time"]),
        assistsStatus: json["assistsStatus"],
        detailClass: DetailClass.fromJson(json["detailClass"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "time": time.toIso8601String(),
        "assistsStatus": assistsStatus,
        "detailClass": detailClass.toJson(),
      };
}

class DetailClass {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String startTime;
  String endTime;
  String day;
  Classroom classroom;
  DetailWork detailWork;

  DetailClass({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.classroom,
    required this.detailWork,
  });

  factory DetailClass.fromJson(Map<String, dynamic> json) => DetailClass(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        day: json["day"],
        classroom: Classroom.fromJson(json["classroom"]),
        detailWork: DetailWork.fromJson(json["detailWork"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "day": day,
        "classroom": classroom.toJson(),
        "detailWork": detailWork.toJson(),
      };
}

class Classroom {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String? nro;
  String description;
  String? codeQr;
  bool status;
  Classroom? module;
  String? name;

  Classroom({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.nro,
    required this.description,
    this.codeQr,
    required this.status,
    this.module,
    this.name,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        nro: json["nro"],
        description: json["description"],
        codeQr: json["codeQR"],
        status: json["status"],
        module:
            json["module"] == null ? null : Classroom.fromJson(json["module"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "nro": nro,
        "description": description,
        "codeQR": codeQr,
        "status": status,
        "module": module?.toJson(),
        "name": name,
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
  String name;
  bool? status;

  Group({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    this.status,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "name": name,
        "status": status,
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
  Classroom typePeriod;
  Classroom management;
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
        typePeriod: Classroom.fromJson(json["typePeriod"]),
        management: Classroom.fromJson(json["management"]),
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
