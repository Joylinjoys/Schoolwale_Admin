import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:web_dashboard_app_tut/screens/AnnouncementList.dart';

import '../Models/class_and_section.dart';

class AddAnnouncementPage extends StatefulWidget {
  
  const AddAnnouncementPage({Key? key}) : super(key: key);

  @override
  _AddAnnouncementPageState createState() => _AddAnnouncementPageState();
}

 

 
class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedClass;
  String? selectedSection;

  String? selectedClassSection;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
 String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Title';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please choose date';
    }
    return null;
  }
   String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please choose Time';
    }
    return null;
  }
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
        selectedDate = new DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        selectedDate= new DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
  }

  final classStream = StreamController<List<String>>();
  final sectionStream = StreamController<List<String>>();
  bool ischange = false;

  @override
  void dispose() {
    idController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
   void _clearText() {
    idController.clear();
    titleController.clear();
    descriptionController.clear();
  
  //  selectedClass.
  //  _marksObtainedController.clear();
  }
 void _submitForm() {
     if (_formKey.currentState!.validate()) {
      // Form is valid, perform form submission
      final _class=selectedClass;
      final Section=selectedSection;
      final titleValue = titleController.text;
      final description = descriptionController.text;
      final scheduledDate = Timestamp.fromDate(selectedDate);
     print('haiiiii');
      print('CLASS: $_class');
      
      final String classSection=_class.toString()+"-"+Section.toString();
       var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate=" ";
    formattedDate = formatter.format(now);
    //print(formattedDate);
//Timestamp myTimeStamp = Timestamp.fromDate(scheduledDate); 
      FirebaseFirestore.instance
          .collection('Announcements')
          .doc(classSection)
          .set(
            {
              'AnnName': titleValue,
              'CreateDate': formattedDate,
              'description':description,
              'scheduledDate':scheduledDate,//DateFormat.yMd().add_jm().format(scheduledDate),
            },
            SetOptions(merge: true),
            
          )
          .then((value) => CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                text: "Inserted Successfuly...",
                width: MediaQuery.of(context).size.width / 5,
              ))
          .catchError((onError) => print("Error:$onError"));
      //TODO: Handle form submission and further actions
    }
    _clearText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Announcement',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Student Results',
                        style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Title:',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              validator: _validateTitle,
                              controller: titleController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Description:',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              validator: _validateDescription,
                              maxLength: 200,
                              controller: descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Date:',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              validator: _validateDate,
                              readOnly: true,
                              controller: TextEditingController(
                                text: DateFormat('yyyy-MM-dd').format(
                                  selectedDate,
                                ),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4.0,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => _selectDate(context),
                                  icon: Icon(Icons.calendar_today),
                                ),
                              ),
                              onTap: () => _selectDate(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Time:',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextFormField(
                              validator: _validateTime,
                              readOnly: true,
                              controller: TextEditingController(
                                text: selectedTime.format(context),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 4.0,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => _selectTime(context),
                                  icon: Icon(Icons.access_time),
                                ),
                              ),
                              onTap: () => _selectTime(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed:  _submitForm,
                           
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => AnnouncementsPage(
                            //       // _submitForm(),
                            //       // regNo: selectedRollNo.toString(),
                            //     ),
                            //   ),
                            // );
                          
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            minimumSize: Size(200, 50),
                          ),
                          child: Text(
                            'ADD',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                     // Text()
                      // Text(DateFormat.yMd().add_jm().format(selectedDate))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}