// To parse this JSON data, do
//
//     final assistenceResponse = assistenceResponseFromJson(jsonString);

import 'dart:convert';

AssistenceResponse assistenceResponseFromJson(String str) =>
    AssistenceResponse.fromJson(json.decode(str));

String assistenceResponseToJson(AssistenceResponse data) =>
    json.encode(data.toJson());

class AssistenceResponse {
  int statudCode;
  List<String> message;
  String error;

  AssistenceResponse({
    required this.statudCode,
    required this.message,
    required this.error,
  });

  factory AssistenceResponse.fromJson(Map<String, dynamic> json) =>
      AssistenceResponse(
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
