import 'package:flutter/material.dart';

class EditTeacherPage extends StatefulWidget {
  const EditTeacherPage({Key? key}) : super(key: key);

  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  String staffType = ''; // Variable to hold the selected staff type
  String selectedClass = ''; // Variable to hold the selected class
  String selectedSection = ''; // Variable to hold the selected section

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.5;

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Teacher Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Class:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: textFieldWidth,
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        // Open class dropdown
                        _showClassDropdown(context);
                      },
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
                      controller: TextEditingController(text: selectedClass),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Section:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: textFieldWidth,
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        // Open section dropdown
                        _showSectionDropdown(context);
                      },
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
                      controller: TextEditingController(text: selectedSection),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Teacher Name:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
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
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Subject:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
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
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload Image:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle image upload
                    },
                    child: Text('Upload'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Qualification:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
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
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter Phone No:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: textFieldWidth,
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
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Staff:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
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
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Set button color to purple
                  ),
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClassDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Class'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('1'),
                onTap: () {
                  setState(() {
                    selectedClass = '1';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('2'),
                onTap: () {
                  setState(() {
                    selectedClass = '2';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('3'),
                onTap: () {
                  setState(() {
                    selectedClass = '3';
                  });
                  Navigator.of(context).pop();
                },
              ),
              // Add more class options as needed
            ],
          ),
        );
      },
    );
  }

  void _showSectionDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('A'),
                onTap: () {
                  setState(() {
                    selectedSection = 'A';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('B'),
                onTap: () {
                  setState(() {
                    selectedSection = 'B';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('C'),
                onTap: () {
                  setState(() {
                    selectedSection = 'C';
                  });
                  Navigator.of(context).pop();
                },
              ),
              // Add more section options as needed
            ],
          ),
        );
      },
    );
  }
}

