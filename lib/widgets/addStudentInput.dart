import 'package:flutter/material.dart';

class StudentInput extends StatelessWidget {
  const StudentInput({super.key, required this.textContent, required this.label, required this.hint});
  final String textContent;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textContent,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                // controller: nameController,
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
