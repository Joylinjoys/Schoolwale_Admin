import 'package:flutter/material.dart';


class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({Key? key}) : super(key: key);

  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  String staffType = ''; // Variable to hold the selected staff type

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Enter Teacher Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Enter Teacher Name:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Choose Subject:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
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
                Text(
                  'Enter Qualification:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Enter Phone No:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
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
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
