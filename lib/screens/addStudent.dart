import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:web_dashboard_app_tut/widgets/addStudentInput.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  
  var items1 = ['choose class', '1', '2', ' 3', '4', '7', '8', ' 9', '10'];
  var items2 = ['choose section', 'A', 'B', 'C'];
  String dropdownvalue1 = 'choose class';
  String dropdownvalue2 = 'choose section';
  String? selectedGender;
  String? selectedBool;

  //String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Student Page',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StudentInput(
                        textContent: "Enter Register No",
                        label: "Register No",
                        hint: "enter Register No here",
                      ),
                      SizedBox(width: 30),
                      StudentInput(
                        textContent: "Enter Name",
                        label: "Name",
                        hint: "enter name here",
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      StudentInput(
                        textContent: "Enter School Name",
                        label: " School Name",
                        hint: "enter school name here",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "choose class",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButton(
                                  // Initial Value
                                  value: dropdownvalue1,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items1.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue1 = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "choose Section",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButton(
                                  // Initial Value
                                  value: dropdownvalue2,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items2.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue2 = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "choose Image",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: StudentInput(
                          textContent: "Enter Phone Number",
                          label: " Phone Number",
                          hint: "enter Phone Number here",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StudentInput(
                        textContent: "Enter Address",
                        label: "Address",
                        hint: "enter Address here",
                      ),
                      SizedBox(width: 30),
                      StudentInput(
                        textContent: "Enter Father Name",
                        label: "Father Name",
                        hint: "enter father name here",
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      StudentInput(
                        textContent: "Enter Mother Name",
                        label: "Mother Name",
                        hint: "enter mother name here",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: StudentInput(
                          textContent: "Enter Date Of Birth",
                          label: "DOB",
                          hint: "DD | MM | YYYY",
                        ),
                      ),
                      SizedBox(width: 30),
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
                                          selectedGender = value;
                                        });
                                      },
                                    ),
                                    Text('Male'),
                                    Radio<String>(
                                      value: 'Female',
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
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
                      SizedBox(width: 30),
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
                      SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: StudentInput(
                          textContent: "Enter Blood Group",
                          label: "Blood Group",
                          hint: "enter Blood Group here",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 140,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.deepPurple, // Set button color to purple
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
