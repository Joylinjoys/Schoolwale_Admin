import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RulesRegulation extends StatefulWidget {
  @override
  _RulesRegulationState createState() => _RulesRegulationState();
}

class _RulesRegulationState extends State<RulesRegulation> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditing = false;
  String _currentTitle = '';
  Map<String, dynamic> _currentDescription = {};

  // Firestore Collection Reference
  final CollectionReference rulesCollection =
  FirebaseFirestore.instance.collection('Rules');

  // Function to update Firestore data
  Future<void> _updateFirestoreData(String title, Map<String, dynamic> description) async {
    await rulesCollection.doc().set({
      'Title': title,
      'Description': description,
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentDataFromFirestore();
  }

  Future<void> _getCurrentDataFromFirestore() async {
    // Assuming you want to retrieve the latest document (if there are multiple documents)
    QuerySnapshot snapshot = await rulesCollection.orderBy('Title', descending: true).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      setState(() {
        _currentTitle = doc['Title'];
        _currentDescription = Map<String, dynamic>.from(doc['Description']);
        _titleController.text = _currentTitle;
        _descriptionController.text = _currentDescription['text'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Rules and Regulation',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      readOnly: !_isEditing,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _descriptionController,
                      readOnly: !_isEditing,
                      maxLines: null,
                      onChanged: (text) {
                        // Update the description map with the text value
                        _currentDescription['text'] = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        if (_isEditing) {
                          _currentTitle = _titleController.text;
                        }
                        _isEditing = !_isEditing;
                      });

                      if (!_isEditing) {
                        // Call function to update Firestore data on 'Done' press
                        await _updateFirestoreData(_currentTitle, _currentDescription);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text(
                      _isEditing ? 'Done' : 'Edit',
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _currentTitle = _titleController.text;
                        // Perform update action here with _currentTitle and _currentDescription
                        print('Title updated: $_currentTitle');
                        print('Description updated: $_currentDescription');
                      });

                      // Call function to update Firestore data
                      await _updateFirestoreData(_currentTitle, _currentDescription);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text(
                      'Update',
                    ),
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