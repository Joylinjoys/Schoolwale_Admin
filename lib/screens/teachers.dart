import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/Addteacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TeacherPage extends StatelessWidget {
  const TeacherPage({Key? key}) : super(key: key);

  Future<void> deleteTeacher(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Teachers').doc(docId).delete();
    } catch (e) {
      print('Error deleting teacher: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Teachers').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        List<DocumentSnapshot> teachers = snapshot.data!.docs;

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
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // You can adjust the font size here
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Subject',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // You can adjust the font size here
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Qualification',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // You can adjust the font size here
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Phone No',
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
                      rows: teachers.asMap().entries.map((entry) {
                        int rowIndex = entry.key;
                        DocumentSnapshot teacher = entry.value;

                        return DataRow(
                          cells: [
                            DataCell(Text(teacher['name'] ?? '')),
                            DataCell(Text(teacher['subject'] ?? '')),
                            DataCell(Text(teacher['qualification'] ?? '')),
                            DataCell(Text(teacher['phoneNo'].toString())),
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
                                              await deleteTeacher(teacher.id);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
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
                MaterialPageRoute(
                  builder: (context) => AddTeacherPage(),
                ),
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