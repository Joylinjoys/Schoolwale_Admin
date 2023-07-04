import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAnnouncementPage extends StatefulWidget {
  const AddAnnouncementPage({Key? key}) : super(key: key);

  @override
  _AddAnnouncementPageState createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedClass = '';
  String selectedSection = '';

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
                      TextField(
                        readOnly: true,
                        onTap: () {
                          // Implement your class selection logic
                          // For example, you can show a dropdown menu or navigate to a class selection screen
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
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
                        'Select Section:',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Replace the TextField with your section selection logic
                      // For example, you can use a dropdown menu or a list to select the section
                      TextField(
                        readOnly: true,
                        onTap: () {
                          // Implement your section selection logic
                          // For example, you can show a dropdown menu or navigate to a section selection screen
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
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
                        'Enter Title:',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
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
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
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
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
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
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
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
