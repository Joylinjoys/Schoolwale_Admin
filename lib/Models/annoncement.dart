import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementInfo {
  final String name;
 // final String description;
  final date;
  AnnouncementInfo(
      {required this.name, this.date});

  AnnouncementInfo.fromJson(Map<String, Object?> json)
      : this(
          name: json['AnnName'] as String,
        //  description: json['description'] as String,
          date: json['scheduledDate'] ,
        );
}
