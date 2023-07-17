class StudentInfo {
  final int registerNumber;
  final phoneNumber;
  final String name;
  final String gender;
  final String schoolName;
  final String fatherName;
  final String motherName;
  final String className;
  final String sectionName;
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
      required this.sectionName,
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
          sectionName: json['Section'] as String,
          address: json['Address'] as String,
          dob: json['DOB'] as String,
        );
  Map<String, Object?> toJson() {
    return {
      'Register No': registerNumber,
      'Registered_number': phoneNumber,
      'Full Name': name,
      'Gender': gender,
      'School Name': schoolName,
      'Fathers Name': fatherName,
      'Mothers Name': motherName,
      'Class': className,
      'Section': sectionName,
      'Address': address,
      'DOB': dob,
    };
  }
  
}


// final StudentInfo s1 = StudentInfo(
//     registerNumber: 20230001,
//     name: "Chintu",
//     gender: "Male",
//     schoolName: "NIT",
//     fatherName: "Ramesh",
//     motherName: "Laila",
//     className: "3",
//     sectionName: "A",
//     address: "Mangalore",
//     dob: "20-02-2009");
// final s2 = StudentInfo(
//     registerNumber: 20230002,
//     name: "Joylin",
//     gender: "Female",
//     schoolName: "NIT",
//     fatherName: "Johnson",
//     motherName: "Jenny",
//     className: "3",
//     sectionName: "A",
//     address: "Mudipu",
//     dob: "20-05-2009");
// final s3 = StudentInfo(
//     registerNumber: 20230003,
//     name: "Azar",
//     gender: "Male",
//     schoolName: "NIT",
//     fatherName: "Irfan",
//     motherName: "Riya",
//     className: "5",
//     sectionName: "A",
//     address: "Mangalore",
//     dob: "23-12-2009");
// final s4 = StudentInfo(
//     registerNumber: 20230004,
//     name: "Angie",
//     gender: "Female",
//     schoolName: "NIT",
//     fatherName: "Cena",
//     motherName: "Bella",
//     className: "3",
//     sectionName: "B",
//     address: "Mangalore",
//     dob: "01-04-2009");


// final List<StudentInfo> students = [
//   StudentInfo(
//       registerNumber: 20230004,
//       name: "Angie",
//       gender: "Female",
//       schoolName: "NIT",
//       fatherName: "Cena",
//       motherName: "Bella",
//       className: "3",
//       sectionName: "B",
//       address: "Mangalore",
//       dob: "01-04-2009"),
//   StudentInfo(
//       registerNumber: 20230003,
//       name: "Azar",
//       gender: "Male",
//       schoolName: "NIT",
//       fatherName: "Irfan",
//       motherName: "Riya",
//       className: "5",
//       sectionName: "A",
//       address: "Mangalore",
//       dob: "23-12-2009"),
//   StudentInfo(
//       registerNumber: 20230002,
//       name: "Joylin",
//       gender: "Female",
//       schoolName: "NIT",
//       fatherName: "Johnson",
//       motherName: "Jenny",
//       className: "3",
//       sectionName: "A",
//       address: "Mudipu",
//       dob: "20-05-2009"),
//   StudentInfo(
//       registerNumber: 20230001,
//       name: "Chintu",
//       gender: "Male",
//       schoolName: "NIT",
//       fatherName: "Ramesh",
//       motherName: "Laila",
//       className: "3",
//       sectionName: "A",
//       address: "Mangalore",
//       dob: "20-02-2009")
// ];
