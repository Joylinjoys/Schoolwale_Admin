import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addEvents.dart';
import 'editEvent.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Event').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final documents = snapshot.data!.docs.map((e) {
          return e.data();
        });
        List<Map<String, dynamic>> eventList = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Events',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.deepPurple.shade400,
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Event List',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 50.0, // Adjust the spacing as needed
                      columns: [
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
                            'Description',
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
                      rows: eventList.map((event) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(event['eventName'] ?? ''),
                            ),
                            DataCell(
                              Text(event['event_date'] ?? ''),
                            ),
                            DataCell(
                              Text(event['description'] ?? ''),
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
                                    MaterialPageRoute(builder: (context) => EditEvent()),
                                  );
                                  // Navigate to edit event page
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
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminEvent()),
              );
              // Handle add button press
              // Implement your logic here to add a new event
            },
            child: Text('ADD'), // Added the text 'ADD' to the button
            backgroundColor: Colors.deepPurple.shade400,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
