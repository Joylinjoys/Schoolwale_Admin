import 'package:flutter/material.dart';
//import 'editNotes.dart';
import 'Editteacher.dart';
import 'UploadNotes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for teachers (replace with your actual data)
    List<Map<String, String>> notes = [
      {
        'class': '1',
        'section': 'A',
        'subject': 'English',
        'unit': '1 unit',
      },
      {
       'class': '2',
        'section': 'A',
        'subject': 'Maths',
        'unit': '2 unit',
      },
     
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notes',
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
                'Notes List',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 100.0,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Class',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Section',
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
                        'Unit',
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
                  rows: notes.map((List) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(List['class'] ?? ''),
                        ),
                        DataCell(
                          Text(List['section'] ?? ''),
                        ),
                        DataCell(
                          Text(List['subject'] ?? ''),
                        ),
                        DataCell(
                          Text(List['unit'] ?? ''),
                        ),
                        DataCell(
                          ElevatedButton(
                            child: Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => EditNotes()),
                              // );
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
            MaterialPageRoute(builder: (context) =>  UploadNotes()),
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
