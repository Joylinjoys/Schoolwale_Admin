import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolInfo {
  final String schoolname;
  final String description;
  final String achievementHead;
  final String achievementContent;
  final String imgurl;
  final String missionHeader;
  final String missionContent;

  SchoolInfo({
    required this.schoolname,
    required this.description,
    required this.achievementHead,
    required this.achievementContent,
    required this.imgurl,
    required this.missionHeader,
    required this.missionContent,
  });

  SchoolInfo.fromJson(Map<String, Object?> json)
      : this(
          schoolname: json['header'] as String,
          description: json['content'] as String,
          achievementHead: json['achievementsHead'] as String,
          achievementContent: json['achievementscontent'] as String,
          imgurl: json['imageUrl'] as String,
          missionHeader: json['missionhead'] as String,
          missionContent: json['missioncontent'] as String,
        );
}
