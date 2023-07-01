import 'package:flutter/material.dart';

class CollegeDetails extends StatelessWidget {
  final TextEditingController _collegeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _missionController = TextEditingController();
  final TextEditingController _achievementsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About School',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter College Name:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _collegeNameController,
                      decoration: InputDecoration(
                        hintText: 'College Name',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'College Image:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle image upload logic here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent.shade200, // Change the button color here
                      ),
                      child: Text('Upload Image'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Description of College:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Our Mission:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _missionController,
                      decoration: InputDecoration(
                        hintText: 'Mission',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Achievements:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _achievementsController,
                      decoration: InputDecoration(
                        hintText: 'Achievements',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle update action here
                  String collegeName = _collegeNameController.text;
                  String description = _descriptionController.text;
                  String mission = _missionController.text;
                  String achievements = _achievementsController.text;

                  print('College Name: $collegeName');
                  print('Description: $description');
                  print('Mission: $mission');
                  print('Achievements: $achievements');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent.shade200, // Change the button color here
                ),
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
