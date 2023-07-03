import 'package:flutter/material.dart';

class EditTeacherPage extends StatefulWidget {
  const EditTeacherPage({Key? key}) : super(key: key);

  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  String staffType = ''; // Variable to hold the selected staff type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Teacher Info',
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Edit Teacher Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Select Class:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                DropdownButton<String>(
                  // Replace with appropriate list of classes
                  items: <String>['1', '2', '3', '4']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle class selection
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Select Section:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                DropdownButton<String>(
                  // Replace with appropriate list of sections
                  items: <String>['A', 'B', 'C', 'D']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle section selection
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Enter Teacher Name:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        width: 200, // Set a fixed width for the TextField
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
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Enter Subject:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        width: 200, // Set a fixed width for the TextField
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
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Upload Image:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle image upload
                  },
                  child: Text('Upload'),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Enter Qualification:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        width: 5.0,// Set a fixed width for the TextField
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
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Enter Phone No:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        width: 200, // Set a fixed width for the TextField
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
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Staff:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
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
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Set button color to purple
                  ),
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
