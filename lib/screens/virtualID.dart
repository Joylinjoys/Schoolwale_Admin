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
     String selectedClass = ''; // Variable to hold the selected class
  String selectedSection = ''; // Variable to hold the selected section
  String title = '';
  
  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.5;
   
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
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    // Open class dropdown
                    _showClassDropdown(context);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: TextEditingController(text: selectedClass),
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
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    // Open section dropdown
                    _showSectionDropdown(context);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: TextEditingController(text: selectedSection),
                ),
              ),
              SizedBox(height: 16),
              
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
                    height: 20,
                  ),
                   SizedBox(
                      width: 140,
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

  void _showClassDropdown(BuildContext context) {
    // TODO: Implement class dropdown logic
  }

  void _showSectionDropdown(BuildContext context) {
    // TODO: Implement section dropdown logic
  }
}