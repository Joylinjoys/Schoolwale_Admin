import 'package:flutter/material.dart';

class RulesRegulation extends StatefulWidget {
  @override
  _RulesRegulationState createState() => _RulesRegulationState();
}

class _RulesRegulationState extends State<RulesRegulation> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isEditing = false;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  maxLines: null,
                  readOnly: !_isEditing,
                  decoration: InputDecoration(
                    hintText:
                    "All students are expected to greet their school teachers when they meet them whether they actually teach them or not.\n• No books (other than text books or library books), magazines Cds, Pen Drive etc should be brought to school.\n• If they are brought, they will be confiscated.\n• Students are expected to respect school property.\n• No student should damage any school furniture,\n write or draw anything on the walls irregular or in any way damage things belonging to others.\n• Any school property damaged even by accident should be reported at once to the class teacher or to the Principal.\n• A student must always come to school in uniform, even during the Practical and special classes.\n• Chewing chocolates and gum in the school premises is strictly forbidden.\n• No students shall indulge in any of the following practices:\n   - spitting in or near the school building.\n   - disfiguring or damaging any school property.\n   - smoking any form of gambling.\n   - use of drugs or intoxicants except on prescription by a regular medical practitioner.",
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text(
                      _isEditing ? 'Done' : 'Edit',
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String enteredText = _textEditingController.text;
                      // Perform update action here with enteredText
                      print('Text entered: $enteredText');
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
