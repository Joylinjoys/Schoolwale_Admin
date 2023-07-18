import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/Result.dart';
import '../Models/class_and_section.dart';
import 'attendanceRegLIst.dart';
import 'package:intl/intl.dart';

class Attendancefirst extends StatefulWidget {
  const Attendancefirst({Key? key}) : super(key: key);
  

  @override
  _AttendancefirstState createState() => _AttendancefirstState();
}

class _AttendancefirstState extends State<Attendancefirst> {
  // String? selectedClass;
  // String? selectedSection;
  // String? selectedRollNo;
   String? selectedClass;
  String? selectedSection;
  String? selectedRollNo;
  String? selectedClassSection;

  
  DateTime selectedDate = DateTime.now();
 // TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


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
  ];

  List<String> rollNos = [
    'Roll No 1',
    'Roll No 2',
    'Roll No 3',
    // Add more roll number options here
  ];
   final sectionStream = StreamController<List<String>>();
   bool ischange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Attendance Page',
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
                        'Select Class and Section',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25),
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
                                      // print(section);
                                      //
                                      // print(sectionStream);

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
                    
                    SizedBox(height: 25),
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
                                          // print(selectedClassSection);
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
                   
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                      Text(
                        'Enter Date:',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        width: 250,
                        child: TextFormField(
                          
                          readOnly: true,
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(selectedDate),
                          ),
                          decoration: InputDecoration(
                             border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            filled: true,
                            fillColor: Colors.white12,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(8.0),
                            //   borderSide: BorderSide.none,
                            // ),
                            // contentPadding: EdgeInsets.symmetric(
                            //   vertical: 12.0,
                            //   horizontal: 16.0,
                            // ),
                            suffixIcon: IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today),
                            ),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    
                      ],
                    ),
                   
                     SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AttendanceList(className: selectedClass.toString(), sectionName: selectedSection.toString(),)),
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
