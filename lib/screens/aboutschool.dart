import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolDetails extends StatefulWidget {
  const SchoolDetails({Key? key}) : super(key: key);

  @override
  _SchoolDetailsState createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  File? _image;
  PlatformFile? _platformFile;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _schoolNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _missionController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form validation passed, handle form submission
      if (_platformFile != null) {
        // Generate a unique filename
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);

        if (kIsWeb) {
          // Upload the file data
          await ref.putData(_platformFile!.bytes!);
        } else {
          // Upload the file
          await ref.putFile(File(_platformFile!.path!));
        }

        // Get the download URL of the uploaded image
        String downloadUrl = await ref.getDownloadURL();

        // Store the school details in Firestore
        await FirebaseFirestore.instance.collection('About').doc('school').set({
          'schoolName': _schoolNameController.text,
          'description': _descriptionController.text,
          'mission': _missionController.text,
          'imageUrl': downloadUrl,
        });

        // Reset the form and clear the file
        _formKey.currentState!.reset();
        setState(() {
          _platformFile = null;
        });
      }
    }
  }

  Future<void> _selectImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _platformFile = result.files.first;
        });
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _platformFile = result.files.first;
        });
      }
    }
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _descriptionController.dispose();
    _missionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'School Details',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'School Details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter School Name',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _schoolNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a school name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "School Name",
                              hintText: "Enter School Name",
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
                          'Upload School Photo',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                          'Enter Discription',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            maxLines: 4,
                            maxLength: 1000,
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Discription';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Discription",
                              hintText: "Enter Discription",
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
                          'Enter Mission',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            maxLines: 4,
                            maxLength: 1000,
                            controller: _missionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a mission';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Mission",
                              hintText: "Enter Mission",
                              border: OutlineInputBorder(),
                            ),
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
        ),
      ),
    );
  }
}
