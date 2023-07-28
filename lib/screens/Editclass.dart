import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditClassSectionPage extends StatefulWidget {
  final Map<String, dynamic> classInfo;

  const EditClassSectionPage({Key? key, required this.classInfo}) : super(key: key);

  @override
  _EditClassSectionPageState createState() => _EditClassSectionPageState();
}

class _EditClassSectionPageState extends State<EditClassSectionPage> {
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
    String editedClass = classController.text;
    List<String> editedSections = sectionsController.text.split(',');

    try {
      await FirebaseFirestore.instance.collection('ClassSections').doc(editedClass).update({
        'class': editedClass,
        'sections': editedSections,
      });

      Navigator.pop(context); // Go back to the previous page after saving changes
    } catch (e) {
      print('Error saving changes: $e');
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
                          child: TextField(
                            controller: classController,
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
                            controller: sectionsController,
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
              onPressed: saveChanges,
              child: Text('EDIT'),
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

