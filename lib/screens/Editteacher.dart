import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/class_and_section.dart';

class EditTeacherPage extends StatefulWidget {
  const EditTeacherPage({Key? key}) : super(key: key);

  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  String staffType = ''; // Variable to hold the selected staff type
  String? selectedClass;
  String? selectedSection;

  final classStream = StreamController<List<String>>();
  final sectionStream = StreamController<List<String>>();
  bool ischange = false;

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.5;

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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Teacher Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Class:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 250,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("ClassSections")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          final List<String> classData = [];
                          final documents = snapshot.data!.docs.map((e) {
                            classData.add(e.id);
                            return e.data();
                          });
                          final List<Sections> teacherList = [];

                          for (var val in documents) {
                            final object = Sections.fromJson(val);
                            teacherList.add(object);
                          }

                          return DropdownButtonFormField<String>(
                            value: selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                selectedClass = newValue;
                                List<String> section = teacherList[
                                (int.parse(selectedClass!)) - 1]
                                    .sections
                                    .cast<String>()
                                    .toList();

                                sectionStream.add(section);
                                ischange = true;
                              });
                            },
                            items: classData
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Section:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 250,
                    child: StreamBuilder(
                        stream: sectionStream.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('Loading...');
                          }

                          final sections = snapshot.data ?? [];

                          return DropdownButtonFormField<String>(
                            value: selectedSection,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSection = newValue;
                              });
                            },
                            items: sections.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Teacher Name:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
                    child: TextFormField(
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Subject:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
                    child: TextFormField(
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload Image:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle image upload
                    },
                    child: Text('Upload'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Qualification:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
                    child: TextField(
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Phone No:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
                    child: TextField(
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Staff:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Teaching',
                        groupValue: staffType,
                        onChanged: (value) {
                          setState(() {
                            staffType = value!;
                          });
                        },
                      ),
                      Text('Teaching'),
                      Radio<String>(
                        value: 'NonTeaching',
                        groupValue: staffType,
                        onChanged: (value) {
                          setState(() {
                            staffType = value!;
                          });
                        },
                      ),
                      Text('Non-Teaching'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Set button color to purple
                  ),
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClassDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Class'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('1'),
                onTap: () {
                  setState(() {
                    selectedClass = '1';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('2'),
                onTap: () {
                  setState(() {
                    selectedClass = '2';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('3'),
                onTap: () {
                  setState(() {
                    selectedClass = '3';
                  });
                  Navigator.of(context).pop();
                },
              ),
              // Add more class options as needed
            ],
          ),
        );
      },
    );
  }

  void _showSectionDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('A'),
                onTap: () {
                  setState(() {
                    selectedSection = 'A';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('B'),
                onTap: () {
                  setState(() {
                    selectedSection = 'B';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('C'),
                onTap: () {
                  setState(() {
                    selectedSection = 'C';
                  });
                  Navigator.of(context).pop();
                },
              ),
              // Add more section options as needed
            ],
          ),
        );
      },
    );
  }
}