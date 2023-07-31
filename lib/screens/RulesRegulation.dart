
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RulesRegulation extends StatelessWidget {
  final TextEditingController _rulesController = TextEditingController();

  void _submitRules(BuildContext context) async {
    String rulesText = _rulesController.text;

    if (rulesText.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('Rules').add({
          'text': rulesText,
        });
        _rulesController.clear();
        print('Rules submitted and saved to Firebase!');

        // Show the success CoolAlert dialog
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Rules submitted successfully!',
          backgroundColor: Colors.deepPurple,
          confirmBtnColor: Colors.deepPurple,
        );
      } catch (e) {
        print('Error saving to Firebase: $e');

        // Show the error CoolAlert dialog
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Error submitting rules. Please try again.',
          backgroundColor: Colors.deepPurple,
          confirmBtnColor: Colors.deepPurple,
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
              onPressed: () => _submitRules(context),
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
