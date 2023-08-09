import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AddAnnouncement.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  Future<void> deleteAnnouncement(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Announcements')
          .doc(docId)
          .delete();
    } catch (e) {
      print('Error deleting announcement: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Announcements').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        List<DocumentSnapshot> announcements = snapshot.data!.docs;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Announcements',
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
                              fontWeight: FontWeight.bold,
                              fontSize: 18, // You can adjust the font size here
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date & Time',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18, // You can adjust the font size here
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18, // You can adjust the font size here
                            ),
                          ),
                        ),
                      ],
                      rows: announcements.asMap().entries.map((entry) {
                        int rowIndex = entry.key;
                        DocumentSnapshot announcement = entry.value;

                        return DataRow(
                            cells: [
                        DataCell(Text(announcement['AnnName'] ?? '')),
                        DataCell(Text(announcement['scheduledDate']?.toDate().toString() ?? '')),
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
                        await deleteAnnouncement(
                        announcement.id);
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
                MaterialPageRoute(builder: (context) => AddAnnouncementPage()),

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