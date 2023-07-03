import 'package:flutter/material.dart';

import 'AddAnnouncement.dart';
import 'EditAnnouncement.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<Map<String, String>> announcements = [
    {
      'id': '1',
      'title': 'Announcement 1',
      'date': '2023-06-30',
      'time': '10:00 AM',
    },
    {
      'id': '2',
      'title': 'Announcement 2',
      'date': '2023-07-01',
      'time': '11:30 AM',
    },
    {
      'id': '3',
      'title': 'Announcement 3',
      'date': '2023-07-02',
      'time': '02:15 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Announcements',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade400,
        actions: [
          IconButton(
            onPressed: () {
              // Handle add button press
              // Implement your logic here to add a new announcement
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Announcement List',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 100.0,
                  columns: [
                    DataColumn(
                      label: Text(
                        'ID',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Time',
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
                  rows: announcements.map((announcement) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(announcement['id'] ?? ''),
                        ),
                        DataCell(
                          Text(announcement['title'] ?? ''),
                        ),
                        DataCell(
                          Text(announcement['date'] ?? ''),
                        ),
                        DataCell(
                          Text(announcement['time'] ?? ''),
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
                                MaterialPageRoute(builder: (context) =>  EditAnnouncementPage()),
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
            MaterialPageRoute(builder: (context) =>  AddAnnouncementPage()),
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
