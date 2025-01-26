import 'package:uuid/uuid.dart';

class Album {
  static const _uuid = Uuid();

  Album({
    required this.name,
    required this.location,
    String? id,
    this.currentItemToPlay = "",
  }) : id = id ?? _uuid.v4();

  String name, location, id, currentItemToPlay;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'id': id,
      'currentItemToPlay': currentItemToPlay
    };
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json["name"] ?? "",
      location: json["location"] ?? "",
      id: json["id"],
      currentItemToPlay: json["currentItemToPlay"],
    );
  }
}
