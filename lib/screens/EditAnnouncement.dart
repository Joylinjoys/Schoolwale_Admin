import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/class_and_section.dart';

class EditAnnouncementPage extends StatefulWidget {
  const EditAnnouncementPage({Key? key}) : super(key: key);

  @override
  _EditAnnouncementPageState createState() => _EditAnnouncementPageState();
}

class _EditAnnouncementPageState extends State<EditAnnouncementPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedClass;
  String? selectedSection;
  
  String? selectedClassSection;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
final sectionStream = StreamController<List<String>>();
   bool ischange = false;
  @override
  void initState() {
    super.initState();
    // Initialize the text controllers and set the initial values
    idController.text = '123'; // Set the initial ID value
    titleController.text = 'Sample Title'; // Set the initial title value
    descriptionController.text =
    'Sample Description'; // Set the initial description value
  }

  @override
  void dispose() {
    idController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter Announcement Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Class:',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Replace the TextField with your class selection logic
                      // For example, you can use a dropdown menu or a list to select the class
                      Container(
                          width: 300,
                          color: Colors.grey[300],
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
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Section:',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Replace the TextField with your section selection logic
                      // For example, you can use a dropdown menu or a list to select the section
                      Container(
                          width: 300,
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
                        controller: titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                          
                            // borderRadius: BorderRadius.circular(8.0),
                            // borderSide: BorderSide.none,
                          ),
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
                        maxLength: 200,
                        controller: descriptionController,
                        maxLines: 3,
                       decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                          
                            // borderRadius: BorderRadius.circular(8.0),
                            // borderSide: BorderSide.none,
                          ),
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
                        readOnly: true,
                        controller: TextEditingController(
                          text: DateFormat('yyyy-MM-dd').format(selectedDate),
                        ),
                       decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                          
                            // borderRadius: BorderRadius.circular(8.0),
                            // borderSide: BorderSide.none,
                          ),
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
                        readOnly: true,
                        controller: TextEditingController(
                          text: selectedTime.format(context),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                          
                            // borderRadius: BorderRadius.circular(8.0),
                            // borderSide: BorderSide.none,
                          ),
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
                ElevatedButton(
                  onPressed: () {
                    String id = idController.text;
                    String title = titleController.text;
                    String description = descriptionController.text;
                    String date = DateFormat('yyyy-MM-dd').format(selectedDate);
                    String time = selectedTime.format(context);

                    // Handle button press
                    // Add logic to save the announcement with the entered details
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Set button color to purple
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 9),

                      Text('Add'),
                    ],
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
