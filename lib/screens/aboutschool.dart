import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'package:web_dashboard_app_tut/Models/aboutSchool.dart';

class SchoolDetails extends StatefulWidget {
  const SchoolDetails({Key? key}) : super(key: key);

  @override
  _SchoolDetailsState createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  TextEditingController _schoolNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _missionController = TextEditingController();

  Future<void> uploadImage() async {
    try {
      if (_image != null) {
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('imageUrl')
            .child('school_photo.jpg');
        await ref.putFile(_image!);
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> saveSchoolDetails() async {
    try {
      String schoolName = _schoolNameController.text.trim();
      String description = _descriptionController.text.trim();
      String mission = _missionController.text.trim();

      await FirebaseFirestore.instance.collection('About').doc('school').set({
        'schoolName': schoolName,
        'description': description,
        'mission': mission,
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
    //  return Scaffold(
    //     body: StreamBuilder(
    //   stream: FirebaseFirestore.instance.collection("About").snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     if (snapshot.hasError ||
    //         snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }
    //     final documents = snapshot.data!.docs.map((e) {
    //       return e.data();
    //     });

    //     final List<SchoolInfo> schoolList = [];

    //     for (var val in documents) {
    //       final object = SchoolInfo.fromJson(val);

    //       schoolList.add(object);
    //     }
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
                      //    controller: ,
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
                            Flexible(
                              child: _image == null
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
                                onPressed: () async {
                                  final image = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  setState(() {
                                    _image = image as File?;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Enter Description',
                  //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  //     ),
                  //     SizedBox(width: 50),
                  //     SizedBox(
                  //       width: 250,
                  //       child: TextField(
                  //         controller: _descriptionController,
                  //         maxLength: 200,
                  //         decoration: InputDecoration(
                  //           labelText: "Description",
                  //           hintText: "Enter Description",
                  //           border: OutlineInputBorder(),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Enter Mission Header',
                  //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  //     ),
                  //     SizedBox(width: 50),
                  //     SizedBox(
                  //       width: 250,
                  //       child: TextField(
                  //        // maxLength: 200,
                  //         decoration: InputDecoration(
                  //           labelText: "Header",
                  //           hintText: "Enter Header",
                  //           border: OutlineInputBorder(),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                //   SizedBox(height: 20),
                // //   SizedBox(height: 20),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Enter Achievement Header',
                //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(width: 50),
                //       SizedBox(
                //         width: 250,
                //         child: TextField(
                //          // maxLength: 200,
                //           decoration: InputDecoration(
                //             labelText: "Header",
                //             hintText: "Enter Header",
                //             border: OutlineInputBorder(),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                   SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enter Achievement',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          maxLines: 4,
                          maxLength: 1000,
                          decoration: InputDecoration(
                            labelText: "Achievement",
                            hintText: "Enter Achievement",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        await uploadImage();
                        await saveSchoolDetails();
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
    //   },
    //     )
    //  );
  }
}
