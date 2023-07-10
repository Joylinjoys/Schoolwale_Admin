import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Models/student_class.dart';
import 'addStudent.dart';
import 'viewProfile.dart';
import 'editStudent.dart';
import 'virtualID.dart';

class Student_main extends StatefulWidget {
  const Student_main({super.key});

  @override
  State<Student_main> createState() => _Student_mainState();
}

class _Student_mainState extends State<Student_main> {
  @override
  // bool isExpanded = false;

  // String dropdownvalue = 'choose class';
  // var items = [
  //   'choose class',
  //   '1 st ',
  //   '2 nd',
  //   '3 rd',
  //   '4 th',
  // ];

  //selectedIndex=1;
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> students = [
      {
        'regno': '101',
        'name': 'Vijesh',
        'class': '1',
        'section': 'C',
      },
      {
        'regno': '202',
        'name': 'Kavitha',
        'class': '2',
        'section': 'B',
      },
      {
        'regno': '301',
        'name': 'Winston',
        'class': '5',
        'section': 'A',
      },
      {
        'regno': '302',
        'name': 'Hilal',
        'class': '1',
        'section': 'B',
      },
    ];
    return StudentListTable(
        //studentsList: students,
        );
  }
}

class StudentListTable extends StatefulWidget {
  //final List<Map<String, String>> studentsList;
  const StudentListTable({Key? key}) : super(key: key);

  @override
  State<StudentListTable> createState() => _StudentListTableState();
}

class _StudentListTableState extends State<StudentListTable> {
  bool folded = true;

  //late List<Map<String, String>> students;
  List<StudentInfo> students = [];
  String dropdownvalue = 'choose class';
  var items = [
    'choose class',
    '1 st ',
    '2 nd',
    '3 rd',
    '4 th',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Students").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final documents = snapshot.data!.docs.map((e) {
          return e.data();
        });

        final List<StudentInfo> studentList = [];

        for (var val in documents) {
          final object = StudentInfo.fromJson(val);

          studentList.add(object);
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Students Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.deepPurple.shade400,
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Student List",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      width: folded ? 56 : 250,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[6],
                      ),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(left: 16),
                          child: !folded
                              ? TextField(
                                  decoration: InputDecoration(
                                      hintText: 'search',
                                      hintStyle:
                                          TextStyle(color: Colors.blue[300]),
                                      border: InputBorder.none),
                                )
                              : null,
                        )),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(folded ? 32 : 0),
                                topRight: Radius.circular(32),
                                bottomLeft: Radius.circular(folded ? 32 : 0),
                                bottomRight: Radius.circular(32),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(
                                  folded ? Icons.search : Icons.close,
                                  color: Colors.blue[900],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  folded = !folded;
                                });
                              },
                            ),
                          ),
                        )
                      ]),
                    ),
                   
                    DropdownButton(
                      // Initial Value
                      //value: dropdownvalue,
                      value: items[1],
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                     SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddStudent()),
                        );
                      },
                      child: Text('ADD',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.deepPurple, // Set button color to purple
                      ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Center(
                    child: DataTable(
                      columnSpacing: 100.0,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Register No',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Class',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Section',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Virtual ID',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                      //students
                      rows: studentList.map((studentList) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Flexible(
                                child: Text(
                                    studentList.registerNumber.toString() ??
                                        ''),
                              ),
                            ),
                            DataCell(
                              Flexible(
                                child: Text(studentList.name as String ?? ''),
                              ),
                            ),
                            DataCell(
                              Flexible(
                                child:
                                    Text(studentList.className as String ?? ''),
                              ),
                            ),
                            DataCell(
                              Flexible(
                                child:
                                    Text(studentList.className as String ?? ''),
                              ),
                            ),
                            DataCell(Flexible(
                              child: ElevatedButton(
                                child: Text('view profile'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .deepPurple, // Set button color to purple
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViewStudent()),
                                  );
                                },
                              ),
                            )),
                            DataCell(Flexible(
                              child: ElevatedButton(
                                child: Text('view virtual ID'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .deepPurple, // Set button color to purple
                                ),
                                onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VirtualId()),
                        );},
                              ),
                            )),
                              DataCell(Flexible(
                              child: ElevatedButton(
                                child: Text('Edit Student'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .deepPurple, // Set button color to purple
                                ),
                                onPressed: () {
                                   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditStudent()),
                        );
                                },
                              ),
                            )),
                            DataCell(Flexible(
                              child: ElevatedButton(
                                child: Text('delete'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .deepPurple, // Set button color to purple
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
                                            onPressed: () {
                                              // Perform delete operation
                                              // You can add your logic here to delete the teacher record
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text('No'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ))
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    ));
    ;
  }
}
