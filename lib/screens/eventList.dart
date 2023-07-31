import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addEvents.dart';
import 'editEvent.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Map<String, dynamic>> eventList = [];

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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Event').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          eventList = snapshot.data!.docs.map((doc) {
            return doc.data() as Map<String, dynamic>;
          }).toList();

          return Padding(
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
                      columnSpacing: 50.0,
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
                              Text(event['eventDate']?.toDate().toString() ?? ''),
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
                                  _navigateToEditEvent(context, event);
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
                                        title: Text('Delete Event'),
                                        content: Text('Are you sure you want to delete this event?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('CANCEL'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('Event')
                                                  .doc(event['eventId'])
                                                  .delete();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('DELETE'),
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
          );
        },
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
  }

  // Method to navigate to EditEvent page and handle updates
  Future<void> _navigateToEditEvent(BuildContext context, Map<String, dynamic> eventData) async {
    final Map<String, dynamic>? updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEvent(eventData: eventData),
      ),
    );

    if (updatedData != null) {
      // Handle the updated data from EditEvent
      // Update the event data in the eventList to reflect changes in the DataTable
      setState(() {
        eventList = eventList.map((event) {
          if (event['eventId'] == eventData['eventId']) {
            event['eventName'] = updatedData['eventName'];
            event['eventDate'] = updatedData['eventDate'];
            event['description'] = updatedData['description'];
          }
          return event;
        }).toList();
      });

      // Show a snackbar with the updated event details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Event updated: ${updatedData['eventName']}'),
        ),
      );
    }
  }
}