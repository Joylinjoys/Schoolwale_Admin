import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/Addteacher.dart';
import 'Editteacher.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for teachers (replace with your actual data)
    List<Map<String, String>> teachers = [
      {
        'name': 'John Doe',
        'subject': 'Mathematics',
        'qualification': 'M.Sc., B.Ed.',
        'phone no': '9980198801',
      },
      {
        'name': 'Jane Smith',
        'subject': 'English',
        'qualification': 'M.A., B.Ed.',
        'phone no': '9980198801',
      },
      {
        'name': 'Mike Johnson',
        'subject': 'Science',
        'qualification': 'B.Sc., M.Ed.',
        'phone no': '9591205729',
      },
      {
        'name': 'Rick Johnson',
        'subject': 'Science',
        'qualification': 'B.Sc., M.Ed.',
        'phone no': '7899325930',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Teachers',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Teachers List',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 100.0,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Subject',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Qualification',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Phone No',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: teachers.map((List) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(List['name'] ?? ''),
                        ),
                        DataCell(
                          Text(List['subject'] ?? ''),
                        ),
                        DataCell(
                          Text(List['qualification'] ?? ''),
                        ),
                        DataCell(
                          Text(List['phone no'] ?? ''),
                        ),
                        DataCell(
                          ElevatedButton(
                            child: Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditTeacherPage()),
                              );
                              // Navigate to edit announcement page
                            },
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text('Are you sure you want to delete?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Perform delete operation
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text('No'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTeacherPage ()),
          );
          // Handle add button press
          // Implement your logic here to add a new announcement
        },
        child: Text('ADD'), // Added the text 'ADD' to the button
        backgroundColor: Colors.deepPurple.shade400,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
