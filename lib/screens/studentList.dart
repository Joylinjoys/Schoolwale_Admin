import 'package:flutter/material.dart';

class Student_main extends StatefulWidget {
final String regno,name,clss,section;
  const Student_main({super.key, required this.regno, required this.name, required this.clss, required this.section});

  @override
  State<Student_main> createState() => _Student_mainState();
}

class _Student_mainState extends State<Student_main> {
  @override
  // bool isExpanded = false;
  bool folded = true;
  String dropdownvalue = 'choose class';
  var items = [
    'choose class',
    '1 st ',
    '2 nd',
    '3 rd',
    '4 th',
  ];

  //selectedIndex=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Students Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Student List",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    value: dropdownvalue,

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
                ],
              ),
              Column(
                children: [
                  DataTable(
                    columns: [
                      DataColumn(label: Text('Register No')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Class')),
                      DataColumn(label: Text('Section')),
                      DataColumn(label: Text('Profile')),
                      DataColumn(label: Text('Virtual ID')),
                      DataColumn(label: Text('Delete')),
                    ],
                    rows: [
                      // DataRow(cells: [
                      //   DataCell(Text('John Doe')),
                      //   DataCell(Text('25')),
                      // ]),
                      // DataRow(cells: [
                      //   DataCell(Text('Jane Doe')),
                      //   DataCell(Text('20')),
                      // ]),
                      // DataRow(cells: [
                      //   DataCell(Text('Peter Smith')),
                      //   DataCell(Text('30')),
                      // ]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
