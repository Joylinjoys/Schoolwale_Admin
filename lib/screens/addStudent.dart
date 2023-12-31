import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:web_dashboard_app_tut/widgets/addStudentInput.dart';
import '../Models/class_and_section.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _virtualIdImage;

  String? selectedClass;
  String? selectedSection;
  String? selectedRollNo;
  String? selectedClassSection;
  final sectionStream = StreamController<List<String>>();
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _registerNumberController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _bloodGroupController = TextEditingController();

  String dropdownvalue1 = 'choose class';
  String dropdownvalue2 = 'choose section';
  String? selectedGender;
  String? selectedBool;

  void _clearText() {
    _studentNameController.clear();
    _registerNumberController.clear();
    _schoolNameController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _fatherNameController.clear();
    _motherNameController.clear();
    _bloodGroupController.clear();
  }
  Future<void> _uploadStudentImage(File imageFile, String regNo, String imageName) async {
    if (imageFile != null) {
      String fileName = 'student_${regNo}_${imageName}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await ref.putFile(imageFile);

      String downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Students').doc(regNo).update({
        imageName: downloadUrl, // Use the provided image name parameter
      });
    }
  }
  bool _imageIsFromWeb(String imagePath) {
    // Check if the image path starts with 'http://' or 'https://'
    return imagePath.startsWith('http://') || imagePath.startsWith('https://');
  }


  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Address';
    }
    return null;
  }

  String? _validateBloodGroup(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a blood group';
    }
    return null;
  }
   String? _validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a DOB';
    }
    return null;
  }
  String? _validateFatherName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter father name';
    }
    return null;
  }
  String? _validateMotherName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mother name';
    }
    return null;
  }
  String? _validateSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter school name';
    }
    return null;
  }
  String? _validateRegNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter register no';
    }
    return null;
  }
   String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone no';
    }
    return null;
  }

  void submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform form submission
      final _regno = _registerNumberController.text;
      final _studentName = _studentNameController.text;
      final _schoolName = _schoolNameController.text;
      final _phoneNO = _phoneNumberController.text;
      final _address = _addressController.text;
      final _fatherName = _fatherNameController.text;
      final _motherName = _motherNameController.text;
      final _bloodGroup = _bloodGroupController.text;

      print(_regno);
      print(_studentName);
      print(_schoolName);
      print(_address);
      print(_phoneNO);
      print(_fatherName);
      print(_motherName);
      print(_bloodGroup);
      print(selectedClass);
      print(selectedSection);
      print(selectedGender);
      print(selectedBool);

      // Upload image if selected
      if (_image != null) {
        await _uploadStudentImage(_image!, _regno, 'profile_picture');
      }

      if (_virtualIdImage != null) {
        await _uploadStudentImage(_virtualIdImage!, _regno, 'virtual_id');
      }

      // Store student details in Firestore
      FirebaseFirestore.instance
          .collection('Students')
          .doc(_regno)
          .set(
        {
          'Register No': int.parse(_regno),
          'Full Name': _studentName,
          'School Name': _schoolName,
          'Address': _address,
          'Registered_number': _phoneNO,
          'Fathers Name': _fatherName,
          'Mothers Name': _motherName,
          'Blood Group': _bloodGroup,
          'Class': selectedClass,
          'Section': selectedSection,
          'Gender': selectedGender,
          'isStudent': selectedBool,
        },
        SetOptions(merge: true),
      )
          .then((value) => CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Inserted Successfully...",
        width: MediaQuery.of(context).size.width / 5,
      ))
          .catchError((onError) => print("Error: $onError"));
    }
  }



  //String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Student Page',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.deepPurple.shade400,
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Enter Student Details',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StudentInput(
                          validator: _validateRegNo,
                          controller: _registerNumberController,
                          textContent: "Enter Register No",
                          label: "Register No",
                          hint: "enter Register No here",
                        ),
                        SizedBox(width: 30),
                        StudentInput(
                          validator: _validateName,
                          controller: _studentNameController,
                          textContent: "Enter Name",
                          label: "Name",
                          hint: "enter name here",
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "choose class",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("ClassSections")
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasError ||
                                            snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                          return Text("Loading");
                                        }

                                        // final classData = snapshot.data ?? [];
                                        final List<String> classData = [];
                                        final documents =
                                            snapshot.data!.docs.map((e) {
                                          classData.add(e.id);
                                          return e.data();
                                        });

                                        final List<Sections> sectionList = [];

                                        for (var val in documents) {
                                          final object = Sections.fromJson(val);

                                          sectionList.add(object);
                                        }
                                        // print(sectionList[0].classs);
                                        return StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return DropdownButtonFormField<
                                                String>(
                                              value: selectedClass,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  //sectionStream.add([]);
                                                  List<String> section = [];
                                                  selectedClass = newValue;
                                                  for (var obj in sectionList) {
                                                    if (obj.classs ==
                                                        selectedClass) {
                                                      section = obj.sections
                                                          .cast<String>()
                                                          .toList();
                                                    }
                                                  }

                                                  sectionStream.add(section);
                                                });
                                              }, //items=classData
                                              items: classData.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              validator: (value) {
                                      if (value == null) {
                                        return 'please select a class';
                                      }
                                      return null;
                                    },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 4),
                                              ),
                                            );
                                            },
                                        );
                                      })

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Flexible(
                          flex: 1,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "choose Section",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  StreamBuilder(
                                      stream: sectionStream.stream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<String>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text('Loading...');
                                        }

                                        final sections = snapshot.data ?? [];

                                        return StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return DropdownButtonFormField<
                                                String>(
                                              value: selectedSection,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedSection = newValue;
                                                  selectedClassSection =
                                                      selectedClass! +
                                                          " " +
                                                          selectedSection!;
                                                });
                                              },
                                              items: sections.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              validator: (value) {
                                      if (value == null) {
                                        return 'please select a section';
                                      }
                                      return null;
                                    },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 4),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        // Flexible(
                        //   flex: 1,
                        //   child: Card(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(18.0),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Choose Virtual ID Image",
                        //                 style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: 20.0,
                        //               ),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   Flexible(
                        //                     child: _virtualIdImage == null
                        //                         ? Text('No image selected.')
                        //                         : Image.network(_virtualIdImage!.path),
                        //                   ),
                        //                   SizedBox(width: 10),
                        //                   SizedBox(
                        //                     width: 150,
                        //                     height: 47,
                        //                     child: ElevatedButton(
                        //                       child: Text('Upload Virtual ID Image'),
                        //                       style: ElevatedButton.styleFrom(
                        //                         primary: Colors.deepPurple,
                        //                       ),
                        //                       onPressed: () async {
                        //                         final image = await _picker.pickImage(
                        //                           source: ImageSource.gallery,
                        //                         );
                        //                         setState(() {
                        //                           _virtualIdImage = image != null ? File(image.path) : null;
                        //                         });
                        //                       },
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(width: 30),
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text(
                        //                     "Choose Profile Picture",
                        //                     style: TextStyle(
                        //                       fontSize: 20,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 20.0,
                        //                   ),
                        //                   Row(
                        //                     mainAxisAlignment: MainAxisAlignment.center,
                        //                     children: [
                        //                       Flexible(
                        //                         child: _image == null
                        //                             ? Text('No image selected.')
                        //                             : Image.network(_image!.path),
                        //                       ),
                        //                       SizedBox(width: 10),
                        //                       SizedBox(
                        //                         width: 150,
                        //                         height: 47,
                        //                         child: ElevatedButton(
                        //                           child: Text('Upload Profile Picture'),
                        //                           style: ElevatedButton.styleFrom(
                        //                             primary: Colors.deepPurple,
                        //                           ),
                        //                           onPressed: () async {
                        //                             final image = await _picker.pickImage(
                        //                               source: ImageSource.gallery,
                        //                             );
                        //                             setState(() {
                        //                               _image = image != null ? File(image.path) : null;
                        //                             });
                        //                           },
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               ),
                        //
                        //
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(width: 30),
                        Flexible(
                          flex: 1,
                          child: StudentInput(
                            validator: _validatePhone,
                            controller: _phoneNumberController,
                            textContent: "Enter Phone Number",
                            label: " Phone Number",
                            hint: "enter Phone Number here",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StudentInput(
                          validator: _validateAddress,
                          controller: _addressController,
                          textContent: "Enter Address",
                          label: "Address",
                          hint: "enter Address here",
                        ),
                        SizedBox(width: 30),
                        StudentInput(
                          validator: _validateFatherName,
                          controller: _fatherNameController,
                          textContent: "Enter Father Name",
                          label: "Father Name",
                          hint: "enter father name here",
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        StudentInput(
                          validator: _validateMotherName,
                          controller: _motherNameController,
                          textContent: "Enter Mother Name",
                          label: "Mother Name",
                          hint: "enter mother name here",
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: StudentInput(
                            validator: _validateDOB,
                            textContent: "Enter Date Of Birth",
                            label: "DOB",
                            hint: "DD | MM | YYYY",
                          ),
                        ),
                        SizedBox(width: 30),
                        Flexible(
                          flex: 1,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose Gender",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  StatefulBuilder(builder: (context, setState) {
                                    return Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Male',
                                          groupValue: selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGender = value;
                                            });
                                          },
                                        ),
                                        Text('Male'),
                                        Radio<String>(
                                          value: 'Female',
                                          groupValue: selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGender = value;
                                            });
                                          },
                                        ),
                                        Text('Female'),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Flexible(
                          flex: 1,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Student",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  StatefulBuilder(builder: (context, setState) {
                                    return Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Yes',
                                          groupValue: selectedBool,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedBool = value;
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio<String>(
                                          value: 'No',
                                          groupValue: selectedBool,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedBool = value;
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Flexible(
                          flex: 1,
                          child: StudentInput(
                            validator: _validateBloodGroup,
                            controller: _bloodGroupController,
                            textContent: "Enter Blood Group",
                            label: "Blood Group",
                            hint: "enter Blood Group here",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 140,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            submitForm();
                          },
                          child: Text('Submit',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
