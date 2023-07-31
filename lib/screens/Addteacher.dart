import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({Key? key}) : super(key: key);

  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  String staffType = '';
  File? _image;
  PlatformFile? _platformFile;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _teacherNameController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  String? _validateSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a school name';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  String? _validateMission(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mission';
    }
    return null;
  }

  String? _validateImage(PlatformFile? file) {
    if (file == null) {
      return 'Please select an image';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form validation passed, handle form submission
      if (_platformFile != null) {
        // Generate a unique filename
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
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

        // Store the teacher details in Firestore with the teacher's name as the document ID
        await FirebaseFirestore.instance
            .collection('Teachers')
            .doc(_teacherNameController.text) // Use teacher's name as document ID
            .set({
          'name': _teacherNameController.text,
          'subject': _subjectController.text,
          'imageUrl': downloadUrl,
          'qualification': _qualificationController.text,
          'phoneNo': _phoneNoController.text,
          'staffType': staffType,
        });

        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Teacher details added successfully!",
          width: MediaQuery.of(context).size.width / 5,
        );

        // Reset the form and clear the file
        _formKey.currentState!.reset();
        setState(() {
          _platformFile = null;
        });
      }
    } else {
      // Form validation failed, show error messages
      setState(() {
        // Use setState to update the UI and trigger auto-validation
      });
    }
  }

  Future<void> _selectImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _platformFile = result.files.first;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _platformFile = result.files.first;
        });
      }
    }
  }

  @override
  void dispose() {
    _teacherNameController.dispose();
    _subjectController.dispose();
    _qualificationController.dispose();
    _phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Teacher',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 700,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Enter Teacher Details',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Teacher Name',
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _teacherNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a teacher name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Teacher Name",
                              hintText: "Enter Teacher Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose Subject',
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _subjectController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please choose a subject';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Subject",
                              hintText: "Choose Subject",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upload Image',
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
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
                              SizedBox(
                                width: 150,
                                height: 47,
                                child: ElevatedButton(
                                  child: Text('Select Image'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                  ),
                                  onPressed: _selectImage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Qualification',
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _qualificationController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a qualification';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Qualification",
                              hintText: "Enter Qualification",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Phone No',
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _phoneNoController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Phone No",
                              hintText: "Enter Phone No",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Staff:',
                          style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Teaching',
                              groupValue: staffType,
                              onChanged: (value) {
                                setState(() {
                                  staffType = value!;
                                });
                              },
                            ),
                            Text('Teaching'),
                            Radio<String>(
                              value: 'NonTeaching',
                              groupValue: staffType,
                              onChanged: (value) {
                                setState(() {
                                  staffType = value!;
                                });
                              },
                            ),
                            Text('Non-Teaching'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .deepPurple, // Set button color to purple
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}