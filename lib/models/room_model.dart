import 'package:ccd2022app/models/sessions_model.dart';

class Room {
  int id;
  String name;
  SessionsGrid session;

  Room({required this.id, required this.name, required this.session});

  static fromJson(json) {
    return Room(
      id: json["id"],
      name: json["name"],
      session: SessionsGrid.fromJson(json["session"]),
    );
  }
}
