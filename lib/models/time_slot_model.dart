import 'package:ccd2022app/models/room_model.dart';

class Timeslot {
  List<Room> rooms;

  Timeslot({required this.rooms});

  static fromJson(json) {
    return Timeslot(
      rooms: List<Room>.from(
        json["rooms"]
            .map(
              (json) => Room.fromJson(json),
            )
            .toList(),
      ),
    );
  }
}
