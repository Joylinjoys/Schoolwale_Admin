class TeacherInfo {
  final String name;
  final String qualification;
  final phonenumber;
  final String subject;
  final String imageUrl;

  TeacherInfo({
    required this.name,
    required this.qualification,
    required this.phonenumber,
    required this.subject,
    required this.imageUrl,
  });

  TeacherInfo.fromJson(Map<String, Object?> json)
      : this(
            name: json['Name'] as String,
            qualification: json['Qualification'] as String,
            phonenumber: json['Phone number'],
            subject: json['Subjects'] as String,
            imageUrl: json['ImageUrl'] as String);

  Map<String, Object?> toJson() {
    return {
      'Name': name,
      'Phone number': phonenumber,
      'Qualification': qualification,
      'Subjects': subject,
      'ImageUrl': imageUrl,
    };
  }
}
