import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/addStudentInput.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  File? _image;
  PlatformFile? _platformFile;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _registerNoController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _schoolNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _motherNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();

  var items1 = ['choose class', '1', '2', '3', '4', '7', '8', '9', '10'];
  var items2 = ['choose section', 'A', 'B', 'C'];
  String dropdownvalue1 = 'choose class';
  String dropdownvalue2 = 'choose section';
  String? selectedGender;
  String? selectedBool;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_platformFile != null) {
        // Generate a unique filename
        String fileName = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString() + '.jpg';
        firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

        if (kIsWeb) {
          // Upload the file data
          await ref.putData(_platformFile!.bytes!);
        } else {
          // Upload the file
          await ref.putFile(File(_platformFile!.path!));
        }

        // Get the download URL of the uploaded image
        String downloadUrl = await ref.getDownloadURL();

        // Store the student details in Firestore
        await FirebaseFirestore.instance.collection('Students').add({
          'registerNo': _registerNoController.text,
          'name': _nameController.text,
          'schoolName': _schoolNameController.text,
          'class': dropdownvalue1,
          'section': dropdownvalue2,
          'imageUrl': downloadUrl,
          'phoneNumber': _phoneNumberController.text,
          'address': _addressController.text,
          'fatherName': _fatherNameController.text,
          'motherName': _motherNameController.text,
          'dob': _dobController.text,
          'gender': selectedGender,
          'isStudent': selectedBool,
          'bloodGroup': _bloodGroupController.text,
          "imageUrl": downloadUrl,
        });

        // Reset the form and clear the file
        _formKey.currentState!.reset();
        setState(() {
          _platformFile = null;
        });
      }
    }
  }

  Future<void> _selectImage(void Function(void Function()) changeState) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        changeState(() {
          _platformFile = result.files.first;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        changeState(() {
          _platformFile = result.files.first;
        });
      }
    }
  }

  @override
  void dispose() {
     _registerNoController.dispose();
     _nameController.dispose();
     _schoolNameController.dispose();
     _phoneNumberController.dispose();
     _addressController.dispose();
     _fatherNameController.dispose();
    _motherNameController.dispose();
     _dobController.dispose();
     _bloodGroupController.dispose();
    super.dispose();
  }

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
                        textContent: "Enter Register No",
                        label: "Register No",
                        hint: "enter Register No here",
                      ),
                      SizedBox(width: 30),
                      StudentInput(
                        textContent: "Enter Name",
                        label: "Name",
                        hint: "enter name here",
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      StudentInput(
                        textContent: "Enter School Name",
                        label: " School Name",
                        hint: "enter school name here",
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
                                DropdownButton(
                                  // Initial Value
                                  value: dropdownvalue1,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items1.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue1 = newValue!;
                                    });
                                  },
                                ),
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
                                DropdownButton(
                                  // Initial Value
                                  value: dropdownvalue2,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items2.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue2 = newValue!;
                                    });
                                  },
                                ),
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
                                  "Choose Image",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    SizedBox(
                                      width: 250,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 90,
                                            width: 90,
                                            child: _platformFile == null
                                                ? Text('No image selected.')
                                                : Text(_platformFile?.name ?? 'No name'),
                                          ),
                                          SizedBox(width: 10),
                                          StatefulBuilder(
                                            builder: (context, setState) {
                                              return ElevatedButton(
                                                onPressed: () {
                                                  _selectImage(setState);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.deepPurple,
                                                ),
                                                child: Text('Select Image'),
                                              );
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: StudentInput(
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
                        textContent: "Enter Address",
                        label: "Address",
                        hint: "enter Address here",
                      ),
                      SizedBox(width: 30),
                      StudentInput(
                        textContent: "Enter Father Name",
                        label: "Father Name",
                        hint: "enter father name here",
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      StudentInput(
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
                                StatefulBuilder(
                                  builder: (context, setState) {
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
                                  }
                                ),
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
                                StatefulBuilder(
                                  builder: (context, setState) {
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
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: StudentInput(
                          textContent: "Enter Blood Group",
                          label: "Blood Group",
                          hint: "enter Blood Group here",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Submit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );

  }
}