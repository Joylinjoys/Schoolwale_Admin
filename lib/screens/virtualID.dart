import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class VirtualId extends StatefulWidget {
  

  const VirtualId({super.key});

  @override
  State<VirtualId> createState() => _VirtualIdState();
}

class _VirtualIdState extends State<VirtualId> {
   final ImagePicker _picker = ImagePicker();
  File? _image;
    String? selectedClass;
  String? selectedSection;
  //String? selectedRollNo;

  List<String> classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    // Add more class options here
  ];

  List<String> sections = [
    'Section A',
    'Section B',
    'Section C',
    // Add more section options here
  ]; // Variable to hold the selected section
  String title = '';
  
  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.2;
   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Virtual ID Page',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                'Select Class:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Container(
                          width: textFieldWidth,
                          child: DropdownButtonFormField<String>(
                            value: selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                selectedClass = newValue;
                              });
                            },
                            items: classes.map<DropdownMenuItem<String>>((String value) {
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
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
              SizedBox(height: 16),
              Text(
                'Select Section:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Container(
                          width: textFieldWidth,
                          child: DropdownButtonFormField<String>(
                            value: selectedSection,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSection = newValue;
                              });
                            },
                            items: sections.map<DropdownMenuItem<String>>((String value) {
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
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
              SizedBox(height: 40),
              
              Container(
                width: textFieldWidth,
               // height:200,
                 child:  Row(
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
                                          primary: Colors
                                              .deepPurple, // Set button color to purple
                                        ),
                                        onPressed: () async {
                                          final image = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          setState(() {
                                            _image = image as File?;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                 
                  ),
                   SizedBox(
                    height: 50,
                  ),
                   SizedBox(
                      width: 
                      140,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Update',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.deepPurple, // Set button color to purple
                        ),
                      ),
                    ),


            ],
          ),
        ),
      ),
    );
  }

  
}