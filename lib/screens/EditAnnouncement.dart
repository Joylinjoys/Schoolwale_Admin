import 'package:flutter/material.dart';

class EditAnnouncementPage extends StatefulWidget {
  const EditAnnouncementPage({Key? key}) : super(key: key);

  @override
  _EditAnnouncementPageState createState() => _EditAnnouncementPageState();
}

class _EditAnnouncementPageState extends State<EditAnnouncementPage> {
  String selectedClass = ''; // Variable to hold the selected class
  String selectedSection = ''; // Variable to hold the selected section
  String title = ''; // Variable to hold the entered title
  String description = ''; // Variable to hold the entered description
  String selectedDate = ''; // Variable to hold the selected date
  TimeOfDay selectedTime = TimeOfDay.now(); // Variable to hold the selected time

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Announcement',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Select Class:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 16),
            Text(
              'Select Section:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 16),
            Text(
              'Enter Title:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Container(
              width: textFieldWidth,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
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
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter Description:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Container(
              width: textFieldWidth,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                maxLines: 3,
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
            SizedBox(height: 16),
            Text(
              'Enter Date:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Open date picker
                _showDatePicker(context);
              },
              child: Container(
                width: textFieldWidth,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: selectedDate),
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
            SizedBox(height: 16),
            Text(
              'Enter Time:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Open time picker
                _showTimePicker(context);
              },
              child: Container(
                width: textFieldWidth,
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedTime.format(context),
                  ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save the announcement
          _saveAnnouncement();
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }

  void _showClassDropdown(BuildContext context) {
    // TODO: Implement class dropdown logic
  }

  void _showSectionDropdown(BuildContext context) {
    // TODO: Implement section dropdown logic
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate.toString(); // Store the selected date
      });
    }
  }

  void _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime; // Store the selected time
      });
    }
  }

  void _saveAnnouncement() {
    // TODO: Implement save announcement logic
  }
}
