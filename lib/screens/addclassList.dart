import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/Addteacher.dart';

class AddPageList extends StatelessWidget {
  const AddPageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for teachers (replace with your actual data)
    List<Map<String, String>> teachers = [
      {
        'Class': '1',
        'section': 'A',

      },
      {
        'Class': '2',
        'section': 'A',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Classes',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20.0,
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
                      'Section',
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
                rows: teachers.map((teacher) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Flexible(
                          child: Text(teacher['Class'] ?? ''),
                        ),
                      ),
                      DataCell(
                        Flexible(
                          child: Text(teacher['section'] ?? ''),
                        ),
                      ),

                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle edit button press
                                // You can navigate to an edit screen or show a dialog
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle delete button press
                                // You can show a confirmation dialog before deleting
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
            ),
            SizedBox(height: 16),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const addTeacherPage ()),
            //       );
            //       //Handle add button press
            //     },
            //     child: Text('ADD'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}