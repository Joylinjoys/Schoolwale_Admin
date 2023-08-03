import 'dart:async';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Models/class_and_section.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({Key? key}) : super(key: key);

  @override
  _UploadNotesState createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  PlatformFile? _platformFile;
  final _formKey = GlobalKey<FormState>();

  final _marksObtainedController = TextEditingController();

  String? selectedClass;
  String? selectedSection;
  // String? selectedRollNo;
  String? selectedClassSection;
  String? _selectedSubject;
  String? _selectedTitle;


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form validation passed, handle form submission
      if (_platformFile != null) {
        // Generate a unique filename
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);

        // Upload the file
        if (kIsWeb) {
          await ref.putData(_platformFile!.bytes!);
        } else {
          await ref.putFile(File(_platformFile!.path!));
        }

        // Get the download URL of the uploaded file
        String downloadUrl = await ref.getDownloadURL();
        print(downloadUrl);

        // Store the download URL in Firestore, under the specified document and subcollection
        await FirebaseFirestore.instance.collection('Notes').doc('3 A').set({
          'Mathematics': {
            'Unit 1': downloadUrl,
          },
          // 'pdfFilePath': downloadUrl,
        });

        // Reset the form and clear the file
        _formKey.currentState!.reset();
        setState(() {
          _platformFile = null;
        });
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Notes uploaded successfully!",
          width: MediaQuery.of(context).size.width / 5,
        );
      }
    }
  }

  Future<void> _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _platformFile = result.files.first;
      });
    }
  }
  final sectionStream = StreamController<List<String>>();
  bool ischange = false;
  final classStream = StreamController<List<String>>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload Notes',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
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
                child: Column(
                  children: [
                    Text(
                      'Upload Notes',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Class:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: StreamBuilder(
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

                                final List<String> classData = [];
                                final documents = snapshot.data!.docs.map((e) {
                                  classData.add(e.id);
                                  return e.data();
                                });

                                final List<Sections> teacherList = [];
                                for (var val in documents) {
                                  final object = Sections.fromJson(val);
                                  teacherList.add(object);
                                }

                                return DropdownButtonFormField<String>(
                                  value: selectedClass,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedClass = newValue;
                                      List<String> section = teacherList[
                                      (int.parse(selectedClass!)) - 1]
                                          .sections
                                          .cast<String>()
                                          .toList();

                                      sectionStream.add(section);
                                      ischange = true;
                                    });
                                  },
                                  items: classData
                                      .map<DropdownMenuItem<String>>(
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
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Section:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: StreamBuilder(
                              stream: sectionStream.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading...');
                                }

                                final sections = snapshot.data ?? [];

                                return DropdownButtonFormField<String>(
                                  value: selectedSection,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedSection = newValue;
                                      selectedClassSection = selectedClass! +
                                          " " +
                                          selectedSection!;
                                    });
                                  },
                                  items: sections.map<DropdownMenuItem<String>>(
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
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Subject',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _selectedSubject,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSubject = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'English',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'Kannada',
                                child: Text('Kannada'),
                              ),
                              DropdownMenuItem(
                                value: 'Hindi',
                                child: Text('Hindi'),
                              ),
                              DropdownMenuItem(
                                value: 'Science',
                                child: Text('Science'),
                              ),
                              DropdownMenuItem(
                                value: 'Social',
                                child: Text('Social'),
                              ),
                            ],
                            validator: (value) {
                                      if (value == null) {
                                        return 'please select a subject';
                                      }
                                      return null;
                                    },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                          'Select Title',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _selectedTitle,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedTitle = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: ' Unit 1',
                                child: Text('Unit 1'),
                              ),
                              DropdownMenuItem(
                                value: 'Unit 2',
                                child: Text('Unit 2'),
                              ),
                              DropdownMenuItem(
                                value: 'Unit 3',
                                child: Text('Unit 3'),
                              ),
                              DropdownMenuItem(
                                value: 'Unit 4',
                                child: Text('Unit 4'),
                              ),
                              DropdownMenuItem(
                                value: 'Unit 5',
                                child: Text('Unit 5'),
                              ),
                            ],
                            validator: (value) {
                                      if (value == null) {
                                        return 'please select a unit';
                                      }
                                      return null;
                                    },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upload File',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: _platformFile == null
                                    ? Text('No file selected.')
                                    : Text(_platformFile!.name),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                height: 47,
                                child: ElevatedButton(
                                  child: Text('Select File'),
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
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple, // Set button color to purple
                          minimumSize: Size(200, 50), // Increase button size
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
