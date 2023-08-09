import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addEvents.dart'; // Import your AddEventPage file here

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  Future<void> deleteEvent(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Event').doc(docId).delete();
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Event').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        List<DocumentSnapshot> events = snapshot.data!.docs;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Events',
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
                    'Event List',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 100.0,
                      columns: [
                        DataColumn(label: Text('Event Name')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Delete')),
                      ],
                      rows: events.asMap().entries.map((entry) {
                        int rowIndex = entry.key;
                        DocumentSnapshot event = entry.value;

                        return DataRow(
                          cells: [
                            DataCell(Text(event['eventName'] ?? '')),
                            DataCell(Text(event['eventDate']?.toDate().toString() ?? '')),
                            DataCell(Text(event['description'] ?? '')),
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
                                        content: Text(
                                            'Are you sure you want to delete?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await deleteEvent(event.id);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Delete'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('CANCEL'),
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
                MaterialPageRoute(builder: (context) => AdminEvent()),
              );
            },
            child: Text('ADD'),
            backgroundColor: Colors.deepPurple.shade400,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}