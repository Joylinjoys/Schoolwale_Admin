import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SchoolDetails extends StatefulWidget {
  const SchoolDetails({Key? key}) : super(key: key);

  @override
  _SchoolDetailsState createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enter Description',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          maxLength: 200,
                          decoration: InputDecoration(
                            labelText: "Description",
                            hintText: "Enter Description",
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
                        child: TextField(
                          maxLength: 200,
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
                      onPressed: () {},
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
