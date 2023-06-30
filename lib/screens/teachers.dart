import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/Addteacher.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for teachers (replace with your actual data)
    List<Map<String, String>> teachers = [
      {
        'name': 'John Doe',
        'subject': 'Mathematics',
        'qualification': 'M.Sc., B.Ed.',
        'phone no': '9980198801',
      },
      {
        'name': 'Jane Smith',
        'subject': 'English',
        'qualification': 'M.A., B.Ed.',
        'phone no': '9980198801',
      },
      {
        'name': 'Mike Johnson',
        'subject': 'Science',
        'qualification': 'B.Sc., M.Ed.',
        'phone no': 'N/A',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Teachers',
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
                      'Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Subject',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Qualification',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Phone No',
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
                          child: Text(teacher['name'] ?? ''),
                        ),
                      ),
                      DataCell(
                        Flexible(
                          child: Text(teacher['subject'] ?? ''),
                        ),
                      ),
                      DataCell(
                        Flexible(
                          child: Text(teacher['qualification'] ?? ''),
                        ),
                      ),
                      DataCell(
                        Flexible(
                          child: Text(teacher['phone no'] ?? ''),
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
                                            // You can add your logic here to delete the teacher record
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTeacherPage()),
                  );
                },
                child: Text('ADD'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
