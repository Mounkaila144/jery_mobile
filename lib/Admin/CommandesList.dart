
// To parse this JSON data, do
//
//     final commandes = commandesFromJson(jsonString);
import 'dart:convert';

List<Commandes> commandesFromJson(String str) => List<Commandes>.from(json.decode(str).map((x) => Commandes.fromJson(x)));

String commandesToJson(List<Commandes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commandes {
  Commandes({
    required this.id,
    required this.status,
    required this.contenue,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int status;
  String contenue;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Commandes.fromJson(Map<String, dynamic> json) => Commandes(
    id: json["id"],
    status: json["status"],
    contenue: json["contenue"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "contenue": contenue,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

