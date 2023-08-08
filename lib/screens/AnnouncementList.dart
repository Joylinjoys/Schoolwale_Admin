import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/annoncement.dart';

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
      'title': 'Announcement 1',
      'datetime': '2023-06-30',
    },
    {
      'title': 'Announcement 2',
      'datetime': '2023-07-01',
    },
    {
      'title': 'Announcement 3',
      'datetime': '2023-07-02',
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
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Announcements").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final documents = snapshot.data!.docs.map((e) {
            return e.data();
          });

          final List<AnnouncementInfo> announcementList = [];

          for (var val in documents) {
            final object = AnnouncementInfo.fromJson(val);
            announcementList.add(object);
          }

          return Center(
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
                            'Title',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date & Time',
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
                      rows: announcementList.map((announcement) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(announcement.name as String ?? ''),
                            ),
                            DataCell(
                              Text(DateFormat.yMd().add_jm().format((announcement.date as Timestamp).toDate()) ?? ''),
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
                                            onPressed: () async {
                                              // Perform delete operation
                                              // await deleteAnnouncement(announcement.id);
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAnnouncementPage()),
          );
        },
        child: Text('ADD'),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> deleteAnnouncement(String docId) async {
    try {
      // Delete the announcement from the Firestore database
      await FirebaseFirestore.instance.collection("Announcements").doc(docId).delete();

      // Delete the announcement from the local list
      setState(() {
        var announcementList;
        announcementList.removeWhere((announcement) => announcement.id == docId);
      });
    } catch (e) {
      print("Error deleting announcement: $e");
      // Handle error if any
    }
  }
}
