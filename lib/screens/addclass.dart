import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/addclassList.dart';

class classfirst extends StatefulWidget {
  const classfirst({Key? key}) : super(key: key);

  @override
  _classfirstState createState() => _classfirstState();
}

class _classfirstState extends State<classfirst> {
  TextEditingController sectionController = TextEditingController();

  String? selectedClass;
  String? selectedSection;
  String? section;

  List<String> classes = [
    ' 1',
    ' 2',
    ' 3',
    ' 4',
    ' 5',
    ' 6',
    ' 7',
    ' 8',
    ' 9',
    ' 10',
    // Add more class options here
  ];

  List<String> sections = [];

  List<Map<String, String>> classList = [
    {
      'Class': '1',
      'Section': 'A',
    },
    {
      'Class': '2',
      'Section': 'C',
    },
    {
      'Class': '3',
      'Section': 'D',
    },
    {
      'Class': '1',
      'Section': 'A',
    },
  ];


  @override
  void initState() {
    super.initState();
  }

  void addToClassList() {
    setState(() {
      String selectedClassValue = selectedClass ?? '';
      String sectionValue = sectionController.text;

      if (selectedClassValue.isNotEmpty && sectionValue.isNotEmpty) {
        Map<String, String> classInfo = {
          'Class': selectedClassValue,
          'Section': sectionValue,
        };

        classList.add(classInfo);

        selectedClass = null;
        sectionController.text = '';
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add classes Page',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.topCenter,
              child: Container(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Class',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                selectedClass = newValue;
                              });
                            },
                            items: classes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add section',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: sectionController,
                            decoration: InputDecoration(
                              labelText: "Add section",
                              hintText: "Enter section",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: addToClassList,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: Size(200, 50),
                        ),
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddPageList(classList: classList)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: Size(200, 50),
                        ),
                        child: Text(
                          'View Classes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}