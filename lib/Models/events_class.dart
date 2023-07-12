class EventInfo {
  final String name;
  final String date;
  final String description;

  EventInfo({
    required this.name,
    required this.date,
    required this.description,
  });

  EventInfo.fromJson(Map<String, Object?> json)
      : this(
    name: json['eventName'] as String,
    date: json['event_date'] as String,
    description: json['description'] as String,
  );
}
