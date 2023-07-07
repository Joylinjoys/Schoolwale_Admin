import 'package:flutter/material.dart';
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
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Class:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
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
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Section:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
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
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Roll No:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: selectedRollNo,
                            onChanged: (newValue) {
                              setState(() {
                                selectedRollNo = newValue;
                              });
                            },
                            items: rollNos.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
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
                            MaterialPageRoute(builder: (context) => ResultPage()),
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
