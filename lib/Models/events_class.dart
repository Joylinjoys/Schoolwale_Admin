import 'package:cloud_firestore/cloud_firestore.dart';

class EventInfo {
  final String name;
  final Timestamp date;
  final String description;

  EventInfo({
    required this.name,
    required this.date,
    required this.description,
  });

  EventInfo.fromJson(Map<String, Object?> json)
      : this(
    name: json['eventName'] as String,
    date: json['eventDate'] as Timestamp,
    description: json['description'] as String,
  );
}
