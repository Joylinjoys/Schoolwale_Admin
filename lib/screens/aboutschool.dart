import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SchoolDetails extends StatefulWidget {
  const SchoolDetails({Key? key}) : super(key: key);

  @override
  _SchoolDetailsState createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  PlatformFile? pickedImage;
  UploadTask? uploadTask;
  TextEditingController _schoolNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _missionController = TextEditingController();

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result == null) return;

    setState(() {
      pickedImage = result.files.first;
    });
  }

  Future<Uint8List?> getImageBytes() async {
    if (pickedImage == null) return null;

    if (kIsWeb) {
      final fileBytes = await pickedImage!.readStream!.first;
      return Uint8List.fromList(fileBytes);
    } else {
      final fileBytes = await pickedImage!.bytes;
      return fileBytes;
    }
  }

  Future<String?> uploadImage() async {
    final imageBytes = await getImageBytes();
    if (imageBytes == null) return null;

    final String? fileName = pickedImage?.name;
    final ref = firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');
    uploadTask = ref.putData(imageBytes);
    await uploadTask!.whenComplete(() {});
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveSchoolDetails(String imageUrl) async {
    try {
      String schoolName = _schoolNameController.text.trim();
      String description = _descriptionController.text.trim();
      String mission = _missionController.text.trim();

      await FirebaseFirestore.instance.collection('About').doc('school').set({
        'schoolName': schoolName,
        'description': description,
        'mission': mission,
        'imageUrl': imageUrl,
      });

      print('School details saved successfully.');
    } catch (e) {
      print('Error saving school details: $e');
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
                        child: TextField(
                          controller: _schoolNameController,
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
                            if (pickedImage != null)
                              Flexible(
                                child: Image.memory(
                                  pickedImage!.bytes!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
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
                                onPressed: selectImage,
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
                        'Enter Mission',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          maxLines: 4,
                          maxLength: 1000,
                          controller: _missionController,
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
                      onPressed: () async {
                        final imageUrl = await uploadImage();
                        if (imageUrl != null) {
                          await saveSchoolDetails(imageUrl);
                        }
                      },
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
    );
  }
}
