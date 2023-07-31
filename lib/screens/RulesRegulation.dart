import 'package:flutter/material.dart';

class RulesRegulation extends StatefulWidget {
  @override
  _RulesRegulationState createState() => _RulesRegulationState();
}

class _RulesRegulationState extends State<RulesRegulation> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditing = false;
  String _currentTitle = '';
  String _currentDescription = '';

  @override
  void initState() {
    super.initState();
    _currentTitle = 'Rules and Regulation';
    _currentDescription =
    'All students are expected to greet their school teachers when they meet them whether they actually teach them or not.\n• No books (other than text books or library books), magazines Cds, Pen Drive etc should be brought to school.\n• If they are brought, they will be confiscated.\n• Students are expected to respect school property.\n• No student should damage any school furniture,\n write or draw anything on the walls irregular or in any way damage things belonging to others.\n• Any school property damaged even by accident should be reported at once to the class teacher or to the Principal.\n• A student must always come to school in uniform, even during the Practical and special classes.\n• Chewing chocolates and gum in the school premises is strictly forbidden.\n• No students shall indulge in any of the following practices:\n   - spitting in or near the school building.\n   - disfiguring or damaging any school property.\n   - smoking any form of gambling.\n   - use of drugs or intoxicants except on prescription by a regular medical practitioner.';
    _titleController.text = _currentTitle;
    _descriptionController.text = _currentDescription;
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: () {
                      setState(() {
                        if (_isEditing) {
                          _currentTitle = _titleController.text;
                          _currentDescription = _descriptionController.text;
                        }
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
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentTitle = _titleController.text;
                        _currentDescription = _descriptionController.text;
                        // Perform update action here with _currentTitle and _currentDescription
                        print('Title updated: $_currentTitle');
                        print('Description updated: $_currentDescription');
                      });
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

