class ProfileConverter {
  final String? profileImageUrl;
  final String? name;
  final String? grade;
  final String? section;
  final String rollNumber;
  final String? schoolName;
  final String? gender;
  final String? dateOfBirth;
  final String? fathersName;
  final String? mothersName;
  final String phoneNo;
  final String? address;

  ProfileConverter({
    required this.profileImageUrl,
    this.name,
    this.grade,
    this.section,
    required this.rollNumber,
    this.schoolName,
    this.gender,
    this.dateOfBirth,
    this.fathersName,
    this.mothersName,
    required this.phoneNo,
    this.address,
  });

  ProfileConverter.fromJson(Map<String, dynamic> json)
      : profileImageUrl = json['ImageUrl'] as String?,
        name = json['Full Name'] as String?,
        grade = json['Class'] as String?,
        section = json['Section'] as String,
        rollNumber = json['Register No'] as String,
        schoolName = json['School Name'] as String?,
        gender = json['Gender'] as String?,
        dateOfBirth = json['DOB'] as String?,
        fathersName = json['Fathers Name'] as String?,
        mothersName = json['Mothers Name'] as String?,
        phoneNo = json['Registered_number'] as String,
        address = json['Address'] as String?;
}
