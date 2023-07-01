import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _formKey = GlobalKey<FormState>();
  final _examNameController = TextEditingController();
  final _regNoController = TextEditingController();
  final _subjectNameController = TextEditingController();
  final _totalMarksController = TextEditingController();
  final _passingMarksController = TextEditingController();
  final _marksObtainedController = TextEditingController();

  @override
  void dispose() {
    _examNameController.dispose();
    _regNoController.dispose();
    _subjectNameController.dispose();
    _totalMarksController.dispose();
    _passingMarksController.dispose();
    _marksObtainedController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform form submission
      final examNameValue = _examNameController.text;
      final regNoValue = _regNoController.text;
      final subjectNameValue = _subjectNameController.text;
      final totalMarksValue = _totalMarksController.text;
      final passingMarksValue = _passingMarksController.text;
      final marksObtainedValue = _marksObtainedController.text;

      // Example: Print form values
      print('Exam Name: $examNameValue');
      print('Registration No: $regNoValue');
      print('Subject Name: $subjectNameValue');
      print('Total Marks: $totalMarksValue');
      print('Passing Marks: $passingMarksValue');
      print('Marks Obtained: $marksObtainedValue');

      // TODO: Handle form submission and further actions
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Enter the Examination Details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter Examination Name:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: _examNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                              'Enter Student Reg. No:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: _regNoController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                              'Enter Subject Name:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: _subjectNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                              'Total Marks:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: _totalMarksController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Passing Marks:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: _passingMarksController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                              'Marks Obtained:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: _marksObtainedController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple, // Set button color to purple
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
