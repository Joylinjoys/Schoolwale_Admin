import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Editclass.dart';

class AddPageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ClassSections').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Map<String, dynamic>> classList = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Classes/Section List',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
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
                    'Classes/Section List',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                            'Sections',
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
                      rows: classList.map((classInfo) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(classInfo['class'] ?? ''),
                            ),
                            DataCell(
                              Text(classInfo['sections'] != null
                                  ? (classInfo['sections'] as List<dynamic>).join(', ')
                                  : ''),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditClassSectionPage(classInfo: classInfo),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.deepPurple,
                              ),
                            ),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Class'),
                                        content: Text('Are you sure you want to delete this class?'),
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
                                                  .collection('ClassSections')
                                                  .doc(classInfo['class'])
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
                                icon: Icon(Icons.delete),
                                color: Colors.red,
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
        );
      },
    );
  }
}
