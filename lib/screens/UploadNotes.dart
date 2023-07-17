import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadNotes extends StatefulWidget {
  const UploadNotes({Key? key}) : super(key: key);

  @override
  _UploadNotesState createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  PlatformFile? _platformFile;
  final _formKey = GlobalKey<FormState>();

  final _marksObtainedController = TextEditingController();

  String? _selectedClass;
  String? _selectedSection;
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
      }
    }
  }




  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _platformFile = result.files.first;
      });
    }
  }

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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Class',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedClass = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'Class I',
                                child: Text('Class I'),
                              ),
                              DropdownMenuItem(
                                value: 'Class II',
                                child: Text('Class II'),
                              ),
                              DropdownMenuItem(
                                value: 'Class III',
                                child: Text('Class III'),
                              ),
                              DropdownMenuItem(
                                value: 'Class IV',
                                child: Text('Class IV'),
                              ),
                              DropdownMenuItem(
                                value: 'Class V',
                                child: Text('Class V'),
                              ),
                            ],
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
                          'Select Section',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _selectedSection,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSection = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'Section A',
                                child: Text('Section A'),
                              ),
                              DropdownMenuItem(
                                value: 'Section B',
                                child: Text('Section B'),
                              ),
                              DropdownMenuItem(
                                value: 'Section C',
                                child: Text('Section C'),
                              ),
                              DropdownMenuItem(
                                value: 'Section D',
                                child: Text('Section D'),
                              ),
                            ],
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
                                  onPressed: _selectFile,
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
