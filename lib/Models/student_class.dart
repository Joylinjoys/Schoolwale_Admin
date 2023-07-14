class StudentInfo {
  final int registerNumber;
  final String phoneNumber;
  final String name;
  final String gender;
  final String schoolName;
  final String fatherName;
  final String motherName;
  final String className;
  final String section;
  final String address;
  final String dob;

  StudentInfo(
      {required this.registerNumber,
      this.phoneNumber = '',
      required this.name,
      required this.gender,
      required this.schoolName,
      required this.fatherName,
      required this.motherName,
      required this.className,
      this.section = 'A',
      required this.address,
      required this.dob});

  StudentInfo.fromJson(Map<String, Object?> json)
      : this(
          registerNumber: json['Register No'] as int,
          phoneNumber: json['Registered_number'] as String,
          name: json['Full Name'] as String,
          gender: json['Gender'] as String,
          schoolName: json['School Name'] as String,
          fatherName: json['Fathers Name'] as String,
          motherName: json['Mothers Name'] as String,
          className: json['Class'] as String,
          section: json['Section'] as String,
          address: json['Address'] as String,
          dob: json['DOB'] as String,
        );
}


final List<StudentInfo> students = [
  StudentInfo(
    registerNumber: 211901, 
    name: 'Janardhan', 
    gender: 'Male', 
    schoolName: 'AIMIT', 
    fatherName: 'Shiva', 
    motherName:'Swathi', 
    className: '3',
    section: 'A',
    address:'Malgalore', 
    dob:'19-01-2007'
  ),
  StudentInfo(
    registerNumber: 211902, 
    name: 'Deeksha', 
    gender: 'Female', 
    schoolName: 'AIMIT', 
    fatherName: 'Radhakrishna', 
    motherName:'Suma', 
    className: '1',
    section: 'A', 
    address:'Bangalore', 
    dob:'16-07-2008'
  ),
  StudentInfo(
   registerNumber: 211903, 
    name: 'Flami', 
    gender: 'Male', 
    schoolName: 'AIMIT', 
    fatherName: 'Joseph', 
    motherName:'Mary', 
    className: '4',
    section: 'C', 
    address:'Vamanjoor', 
    dob:'10-11-2005'
  ),
  StudentInfo(
    registerNumber: 211904, 
    name: 'Safwan', 
    gender: 'Male', 
    schoolName: 'AIMIT', 
    fatherName: 'Raheem', 
    motherName:'Fathima', 
    className: '3',
    section: 'A', 
    address:'Beeri', 
    dob:'09-01-2007'
  ),
  StudentInfo(
    registerNumber: 211905, 
    name: 'Kavitha', 
    gender: 'Female', 
    schoolName: 'AIMIT', 
    fatherName: 'Madhav', 
    motherName:'Saroja', 
    className: '3', 
    section: 'B',
    address:'Malgalore', 
    dob:'19-01-2007'
  ),
  StudentInfo(
    registerNumber: 211906, 
    name: 'Listen', 
    gender: 'Male', 
    schoolName: 'AIMIT', 
    fatherName: 'Nelson', 
    motherName:'Manisha', 
    className: '5',
    section: 'A', 
    address:'Udupi', 
    dob:'10-03-2006'
  ),
];
