import 'package:flutter/material.dart';

import 'addEvents.dart';
import 'editEvent.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Map<String, String>> announcements = [
    {
      'id': '1',
      'name': 'Singing',
      'date': '2023-06-30',
      'image': 'sfsfsfskkkkkkkkkkkkkkkkkkkk',
    },
    {
       'id': '2',
      'name': 'Dancing',
      'date': '2023-06-30',
      'image': 'sfsfsfskkkkkkkkkkbbkkkkkkkkkk',
    },
    { 'id': '3',
      'name': 'Drawing',
      'date': '2023-06-30',
      'image': 'sfsfsfskkkkkkkkkkkkkkkkkkkk',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Events',
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
                'Event List',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 100.0,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Event ID',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Event Name',
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
                        'Image URL',
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
                          Text(announcement['name'] ?? ''),
                        ),
                        DataCell(
                          Text(announcement['date'] ?? ''),
                        ),
                        DataCell(
                          Text(announcement['image'] ?? ''),
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
                                MaterialPageRoute(builder: (context) =>  EditEvent()),
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
            MaterialPageRoute(builder: (context) => AdminEvent ()),
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
