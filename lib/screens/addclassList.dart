import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/Addteacher.dart';
import 'addclass.dart';

class AddPageList extends StatefulWidget {
  final List<Map<String, String>> classList;

  const AddPageList({Key? key, required this.classList}) : super(key: key);

  @override
  _AddPageListState createState() => _AddPageListState();
}

class _AddPageListState extends State<AddPageList> {


  void deleteClass(int index) {
    setState(() {
      widget.classList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Classes/section List',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20.0,
            dividerThickness: 1.0,
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
            rows: widget.classList.asMap().entries.map((entry) {
              final index = entry.key;
              final classInfo = entry.value;

              return DataRow(
                cells: [
                  DataCell(
                    Container(
                      width: 100,
                      child: Text(
                        classInfo['Class'] ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 100,
                      child: Text(
                        classInfo['Section'] ?? '',
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
                              MaterialPageRoute(builder: (context) => classfirst()),
                            );

                            // Handle edit button press
                            // You can navigate to an edit screen or show a dialog
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.deepPurple,
                        ),
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
                                      onPressed: () {
                                        deleteClass(index);
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
        ),
      ),
    );
  }
}