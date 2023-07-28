import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:web_dashboard_app_tut/screens/addclassList.dart';

class EditClassSectionPage extends StatefulWidget {
  final Map<String, dynamic> classInfo;

  const EditClassSectionPage({Key? key, required this.classInfo}) : super(key: key);

  @override
  _EditClassSectionPageState createState() => _EditClassSectionPageState();
}

class _EditClassSectionPageState extends State<EditClassSectionPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController classController;
  late TextEditingController sectionsController;

  @override
  void initState() {
    super.initState();
    classController = TextEditingController(text: widget.classInfo['class'].toString());
    sectionsController = TextEditingController(text: (widget.classInfo['sections'] as List<dynamic>).join(','));
  }

  @override
  void dispose() {
    classController.dispose();
    sectionsController.dispose();
    super.dispose();
  }

  void saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      String editedClass = classController.text;
      List<String> editedSections = sectionsController.text.split(',');

      try {
        await FirebaseFirestore.instance.collection('ClassSections').doc(editedClass).update({
          'class': editedClass,
          'sections': editedSections,
        });

        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Edited Successfully",
          width: MediaQuery.of(context).size.width / 4,
          onConfirmBtnTap: () {
            Navigator.pop(context); // Go back to the previous page after saving changes
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPageList()),
            );
          },
        );
      } catch (e) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Error Saving Changes",
          width: MediaQuery.of(context).size.width / 4,
          confirmBtnColor: Colors.deepPurple,
          onConfirmBtnTap: () {
            Navigator.pop(context); // Go back to the previous page after saving changes
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Class and Sections',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Class:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              controller: classController,
                              decoration: InputDecoration(
                                labelText: "Class",
                                hintText: "Enter Class",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a class';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Sections:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              controller: sectionsController,
                              decoration: InputDecoration(
                                labelText: "Sections",
                                hintText: "Enter Sections",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter sections';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: saveChanges,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple, // Set button color to purple
                            minimumSize: Size(200, 50), // Increase button size
                          ),
                          child: Text(
                            'EDIT',
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
      ),
    );
  }
}
