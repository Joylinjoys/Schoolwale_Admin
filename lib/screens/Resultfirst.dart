import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/Models/class_and_section.dart';
import 'package:web_dashboard_app_tut/screens/Result.dart';

class Resultfirst extends StatefulWidget {
  const Resultfirst({Key? key}) : super(key: key);

  @override
  _ResultfirstState createState() => _ResultfirstState();
}

class _ResultfirstState extends State<Resultfirst> {
  String? selectedClass;
  String? selectedSection;
  String? selectedRollNo;
  String? selectedClassSection;

  static Future getClass() async {
    QuerySnapshot response1 =
        await FirebaseFirestore.instance.collection("ClassSections").get();
    List<String> classnames = [];
    List<Object?> list1 = response1.docs.map((e) {
      classnames.add(e.id);
      return e.data();
    }).toList();

    // print(list1[0]);
    // print(classnames);
    // print(classnames.runtimeType);

    return classnames;
  }

  static getSections(String className) async {
    List<String>? list = [];
    var collection = FirebaseFirestore.instance.collection('ClassSections');
    var docSnapshot = await collection.doc(className).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      List<String>? value = [...data?['sections']];
      list = [...data?['sections']];
      // print(value.length);
      // print(value);
      // print(value.runtimeType);
      // print(value?[0].toString());
    }

    return await list;
  }

  var classss = getClass();
  var ss = getSections("4");

  // List<String> lst = getSections("4");
  List<String> classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    // Add more class options here
  ];

  // List<String> sections = [
  //   'Section A',
  //   'Section B',
  //   'Section C',
  //   // Add more section options here
  // ];

  List<String> rollNos = [
    'Roll No 1',
    'Roll No 2',
    'Roll No 3',
    // Add more roll number options here
  ];

  final sectionStream = StreamController<List<String>>();
  bool ischange = false;
  final classStream = StreamController<List<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Result Page',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.topCenter,
              child: Container(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Enter Student Results',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
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

                                // final classData = snapshot.data ?? [];
                                final List<String> classData = [];
                                final documents = snapshot.data!.docs.map((e) {
                                  classData.add(e.id);
                                  return e.data();
                                });
                                //final dd = classData;
                                final List<Sections> teacherList = [];

                                for (var val in documents) {
                                  final object = Sections.fromJson(val);

                                  teacherList.add(object);
                                }

                                // print(teacherList[4].sections);

                                return DropdownButtonFormField<String>(
                                  value: selectedClass,
                                  onChanged: (newValue) {
                                    setState(() {
                                      //sectionStream.add([]);
                                      selectedClass = newValue;
                                      List<String> section = teacherList[
                                              (int.parse(selectedClass!)) - 1]
                                          .sections
                                          .cast<String>()
                                          .toList();

                                      sectionStream.add(section);
                                      ischange = true;
                                    });
                                  }, //items=classData
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
                                      selectedClassSection = selectedClass! +
                                          " " +
                                          selectedSection!;
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
                          'Select Roll No:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Students")
                                  .where('Class',
                                      isEqualTo: selectedClassSection)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasError ||
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                                List<String> lss = [];
                                final documents = snapshot.data!.docs.map((e) {
                                  lss.add(e.id.toString());
                                  return e.data();
                                });

                                return DropdownButtonFormField<String>(
                                  value: selectedRollNo,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedRollNo = newValue;
                                    });
                                  },
                                  items: lss.map<DropdownMenuItem<String>>(
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: Size(200, 50),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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

class DATA {}
