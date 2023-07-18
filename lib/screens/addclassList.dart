import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Editclass.dart';

class AddPageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ClassSections').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final classList = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

          return Center(
            child: DataTable(
              columnSpacing: 10.0,
              dividerThickness: 3.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              columns: const [
                DataColumn(
                  label: Text(
                    'Class',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Sections',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(),
                ),
              ],
              rows: classList.asMap().entries.map((entry) {
                final index = entry.key;
                final classInfo = entry.value;

                String className = classInfo['class'].toString();
                List<String> sections = (classInfo['sections'] as List<dynamic>).cast<String>();

                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 100,
                        child: Text(
                          className,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 100,
                        child: Text(
                          sections.join(', '),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                          IconButton(
                            onPressed: () async {
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
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

