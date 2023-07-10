class StudentInfo {
  final int registerNumber;
  final phoneNumber;
  final String name;
  final String gender;
  final String schoolName;
  final String fatherName;
  final String motherName;
  final String className;
  final String address;
  final String dob;
  StudentInfo(
      {required this.registerNumber,
      this.phoneNumber,
      required this.name,
      required this.gender,
      required this.schoolName,
      required this.fatherName,
      required this.motherName,
      required this.className,
      required this.address,
      required this.dob});

  StudentInfo.fromJson(Map<String, Object?> json)
      : this(
          registerNumber: json['Register No'] as int,
          phoneNumber: json['Registered_number'],
          name: json['Full Name'] as String,
          gender: json['Gender'] as String,
          schoolName: json['School Name'] as String,
          fatherName: json['Fathers Name'] as String,
          motherName: json['Mothers Name'] as String,
          className: json['Class'] as String,
          address: json['Address'] as String,
          dob: json['DOB'] as String,
        );
}
