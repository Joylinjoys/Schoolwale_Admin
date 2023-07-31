
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RulesRegulation extends StatelessWidget {
  final TextEditingController _rulesController = TextEditingController();

  void _submitRules() async {
    String rulesText = _rulesController.text;

    if (rulesText.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('Rules').add({
          'text': rulesText,
        });
        _rulesController.clear();
        print('Rules submitted and saved to Firebase!');
      } catch (e) {
        print('Error saving to Firebase: $e');
      }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _rulesController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Enter Rules and Regulations',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRules,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RulesRegulation(),
  ));
}
