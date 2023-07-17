import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:web_dashboard_app_tut/widgets/addStudentInput.dart';

class EditStudent extends StatefulWidget {
  const EditStudent({Key? key}) : super(key: key);

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  var items1 = ['choose class', '1', '2', ' 3', '4', '7', '8', ' 9', '10'];
  var items2 = ['choose section', 'A', 'B', 'C'];
  String dropdownvalue1 = 'choose class';
  String dropdownvalue2 = 'choose section';
  String selectedGender = '';
  String? selectedBool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Teacher Page',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Enter Student Details',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // ...rest of the code...

                Flexible(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Gender",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text('Male'),
                              Radio<String>(
                                value: 'Female',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text('Female'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ...rest of the code...

                Flexible(
                  flex: 1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Student",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Yes',
                                groupValue: selectedBool,
                                onChanged: (value) {
                                  setState(() {
                                    selectedBool = value;
                                  });
                                },
                              ),
                              Text('Yes'),
                              Radio<String>(
                                value: 'No',
                                groupValue: selectedBool,
                                onChanged: (value) {
                                  setState(() {
                                    selectedBool = value;
                                  });
                                },
                              ),
                              Text('No'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ...rest of the code...

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, // Set button color to purple
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}