import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTimetable extends StatefulWidget {
  const AddTimetable({Key? key}) : super(key: key);

  @override
  _AddTimetableState createState() => _AddTimetableState();
}

class _AddTimetableState extends State<AddTimetable> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _classNameController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  PlatformFile? _platformFile;

  Future<void> _selectImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _platformFile = result.files.first;
        });
      }
    } else {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image as File?;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form validation passed, handle form submission
      if (_platformFile != null) {
        // Generate a unique filename
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);

        if (kIsWeb && _platformFile != null) {
          // Upload the file data (for web)
          await ref.putData(_platformFile!.bytes!);
        } else if (_image != null) {
          // Upload the file (for mobile)
          await ref.putFile(_image!);
        }

        // Get the download URL of the uploaded image
        String downloadUrl = await ref.getDownloadURL();
        print(downloadUrl);

        // Store the timetable details in Firestore
        String className = _classNameController.text;
        String section = _sectionController.text;

        // Create a document with className as the document ID
        DocumentReference classDocumentRef = FirebaseFirestore.instance.collection('Timetable').doc(className);

        // Set the timetable details as subfields inside the document
        await classDocumentRef.set({
          section: {
            'imageUrl': downloadUrl,
          },
        }, SetOptions(merge: true)); // Use merge option to update existing fields and add new fields

        // Reset the form and clear the file
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _platformFile = null;
        });
      }
    }
  }

  @override
  void dispose() {
    _classNameController.dispose();
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Timetable',
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
                      'Add Timetable',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Class Name',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _classNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a class name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Class Name",
                              hintText: "Enter Class Name",
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
                          'Enter Section',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _sectionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a section';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Section",
                              hintText: "Enter Section",
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
                          'Upload Timetable Image',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: kIsWeb
                                    ? SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: _platformFile == null
                                      ? Text('No image selected.')
                                      : Text(_platformFile?.name ?? 'No name'),
                                )
                                    : _image == null
                                    ? Text('No image selected.')
                                    : Image.file(_image!),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                height: 47,
                                child: ElevatedButton(
                                  child: Text('Upload Image'),
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
                    SizedBox(
                      width: 140,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Add',
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
