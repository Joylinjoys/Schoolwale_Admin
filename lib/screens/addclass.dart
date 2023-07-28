import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:web_dashboard_app_tut/screens/addclassList.dart';

class classfirst extends StatefulWidget {
  const classfirst({Key? key}) : super(key: key);

  @override
  _classfirstState createState() => _classfirstState();
}

class _classfirstState extends State<classfirst> {
  TextEditingController sectionController = TextEditingController();

  String? selectedClass;
  List<String> classes = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  void dispose() {
    sectionController.dispose();
    super.dispose();
  }

  Future<void> addToClassList() async {
    String sectionsValue = sectionController.text.trim();

    if (selectedClass != null && sectionsValue.isNotEmpty) {
      List<String> sections = sectionsValue.split(',');

      try {
        await FirebaseFirestore.instance
            .collection('ClassSections')
            .doc(selectedClass)
            .set({
          'class': selectedClass,
          'sections': FieldValue.arrayUnion(sections),
        });

        print('Class added successfully.');
        sectionController.clear();

        // Show success message dialog
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Class added successfully.",
          width: MediaQuery.of(context).size.width / 5,
        );
      } catch (e) {
        print('Error adding class: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Classes Page',
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
                          'Add Class:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
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
                          'Add Sections:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: sectionController,
                            decoration: InputDecoration(
                              labelText: "Sections",
                              hintText: "Enter Sections",
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
                            MaterialPageRoute(
                              builder: (context) => AddPageList(),
                            ),
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
