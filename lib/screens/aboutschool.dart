import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SchoolDetails extends StatefulWidget {
  const SchoolDetails({Key? key}) : super(key: key);

  @override
  _SchoolDetailsState createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  TextEditingController _schoolNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _missionController = TextEditingController();

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<Uint8List?> getFileBytes() async {
    if (pickedFile == null) return null;

    if (kIsWeb) {
      final fileBytes = await pickedFile!.readStream!.first;
      return Uint8List.fromList(fileBytes);
    } else {
      final fileBytes = await pickedFile!.bytes;
      return fileBytes;
    }
  }

  Future<String?> uploadImage() async {
    final fileBytes = await getFileBytes();
    if (fileBytes == null) return null;

    final String? fileName = pickedFile?.name;
    final ref = FirebaseStorage.instance.ref().child('files/$fileName');
    uploadTask = ref.putData(fileBytes);
    await uploadTask!.whenComplete(() {});
    final urlDownload = await ref.getDownloadURL();
    print('Download Link: $urlDownload');
    return urlDownload;
  }

  Future<void> saveSchoolDetails(String imageUrl) async {
    try {
      String schoolName = _schoolNameController.text.trim();
      String description = _descriptionController.text.trim();
      String mission = _missionController.text.trim();

      await FirebaseFirestore.instance
          .collection('About')
          .doc('school')
          .set({
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
                            if (pickedFile != null)
                              Flexible(
                                child: Image.memory(
                                  pickedFile!.bytes!,
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
                                onPressed: selectFile,
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