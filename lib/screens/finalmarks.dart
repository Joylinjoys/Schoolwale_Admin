import 'package:flutter/material.dart';

class Finalexam extends StatefulWidget {
  const Finalexam({Key? key}) : super(key: key);

  @override
  _FinalexamState createState() => _FinalexamState();
}

class _FinalexamState extends State<Finalexam> {
  final _formKey = GlobalKey<FormState>();
  final _examNameController = TextEditingController();
  final _totalMarksController = TextEditingController();
  final _passingMarksController = TextEditingController();
  final _marksObtainedController = TextEditingController();

  String? _selectedSubject;

  @override
  void dispose() {
    _examNameController.dispose();
    _totalMarksController.dispose();
    _passingMarksController.dispose();
    _marksObtainedController.dispose();
    super.dispose();
  }

String? _validateExamName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a exam name';
    }
    return null;
  }

  String? _validateMark(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter written exam mark';
    }
    return null;
  }

  String? _validateMarksobtained(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a obtained marks';
    }
    return null;
  }
   String? _validatePassingMark(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a internal assessment mark';
    }
    return null;
  }
  String? _validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please choose a subject';
    }
    return null;
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
                      'Enter  Final Examination Details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Examination Name',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _examNameController,
                            validator: _validateExamName,
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
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                            validator: _validateSubject,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                          'Written Exam Marks',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            validator: _validateMark,
                            controller: _totalMarksController,
                            decoration: InputDecoration(
                              labelText: "Written Exam",
                              hintText: "Written Exam  Marks /80",
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
                          'Internal Assesment Marks',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            validator: _validatePassingMark,
                            controller: _passingMarksController,
                            decoration: InputDecoration(
                              labelText: "Internal Assesment",
                              hintText: "Internal Assessment Marks /20",
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
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _marksObtainedController,
                            validator: _validateMarksobtained,
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
            ),
          ),
        ),
      ),
    );
  }
}
