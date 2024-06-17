// To parse this JSON data, do
//
//     final assistenceVirtualBad = assistenceVirtualBadFromJson(jsonString);

import 'dart:convert';

AssistenceVirtualBad assistenceVirtualBadFromJson(String str) =>
    AssistenceVirtualBad.fromJson(json.decode(str));

String assistenceVirtualBadToJson(AssistenceVirtualBad data) =>
    json.encode(data.toJson());

class AssistenceVirtualBad {
  int statudCode;
  List<String> message;
  String error;

  AssistenceVirtualBad({
    required this.statudCode,
    required this.message,
    required this.error,
  });

  factory AssistenceVirtualBad.fromJson(Map<String, dynamic> json) =>
      AssistenceVirtualBad(
        statudCode: json["statudCode"],
        message: List<String>.from(json["message"].map((x) => x)),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "statudCode": statudCode,
        "message": List<dynamic>.from(message.map((x) => x)),
        "error": error,
      };
}
