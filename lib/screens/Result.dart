import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/finalmarks.dart';

class ResultPage extends StatefulWidget {
  // final String exam;
  final String regNo;
  const ResultPage({Key? key, required this.regNo}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState(regNo);
}

class _ResultPageState extends State<ResultPage> {
  //late final String exam;
  late final String regNo;
  final _formKey = GlobalKey<FormState>();
  final _examNameController = TextEditingController();
  final _totalMarksController = TextEditingController();
  final _passingMarksController = TextEditingController();
  final _marksObtainedController = TextEditingController();

  String? _selectedSubject;

  _ResultPageState(this.regNo);

  @override
  void dispose() {
    _examNameController.dispose();
    _totalMarksController.dispose();
    _passingMarksController.dispose();
    _marksObtainedController.dispose();
    super.dispose();
  }

  void _clearText() {
    _examNameController.clear();
    _totalMarksController.clear();
    _passingMarksController.clear();
    _marksObtainedController.clear();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform form submission
      final examNameValue = _examNameController.text;
      final subjectNameValue = _selectedSubject;
      final totalMarksValue = _totalMarksController.text;
      final passingMarksValue = _passingMarksController.text;
      final marksObtainedValue = _marksObtainedController.text;

      // Example: Print form values

      print('Exam Name: $examNameValue');
      print('Subject Name: $subjectNameValue');
      print('Total Marks: $totalMarksValue');
      print('Passing Marks: $passingMarksValue');
      print('Marks Obtained: $marksObtainedValue');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      FirebaseFirestore.instance
          .collection(examNameValue)
          .doc(regNo)
          .set(
            {
              'Passing_marks': int.parse(passingMarksValue),
              'Total_marks': int.parse(totalMarksValue),
              'SubjectMarks': {
                '$subjectNameValue': int.parse(marksObtainedValue)
              },
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
          'Result Page',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 700,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Enter Examination Details',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Examination Name',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _examNameController,
                            decoration: InputDecoration(
                              labelText: "Examination Name",
                              hintText: "Examination Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Subject',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _selectedSubject,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSubject = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: 'English',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'Kannada',
                                child: Text('Kannada'),
                              ),
                              DropdownMenuItem(
                                value: 'Hindi',
                                child: Text('Hindi'),
                              ),
                              DropdownMenuItem(
                                value: 'Science',
                                child: Text('Science'),
                              ),
                              DropdownMenuItem(
                                value: 'Social',
                                child: Text('Social'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Marks',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _totalMarksController,
                            decoration: InputDecoration(
                              labelText: "Total Marks",
                              hintText: "Total Marks",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Passing Marks',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _passingMarksController,
                            decoration: InputDecoration(
                              labelText: "Passing Marks",
                              hintText: "Passing Marks",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Marks Obtained',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _marksObtainedController,
                            decoration: InputDecoration(
                              labelText: "Marks Obtained",
                              hintText: "Marks Obtained",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.deepPurple, // Set button color to purple
                          minimumSize: Size(200, 50), // Increase button size
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
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Finalexam()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.deepPurple, // Set button color to purple
                          minimumSize: Size(200, 50), // Increase button size
                        ),
                        child: Text(
                          'Add Final Exam Marks',
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
