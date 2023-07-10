class TeacherInfo {
  final String name;
  final String qualification;
  final phonenumber;
  final String subject;

  TeacherInfo({
    required this.name,
    required this.qualification,
    required this.phonenumber,
    required this.subject,
  });

  TeacherInfo.fromJson(Map<String, Object?> json)
      : this(
    name: json['Name'] as String,
    qualification: json['Qualification'] as String,
    phonenumber: json['Phone number'],
    subject: json['Subjects'] as String,
  );
}
