import 'package:flutter/material.dart';

class StudentInput extends StatelessWidget {
  const StudentInput(
      {super.key,
      this.controller,
      required this.textContent,
      required this.label,
      required this.hint, required this.validator});
  final String textContent;
  final String label;
  final String hint;
  final TextEditingController? controller;

  final  validator;

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
              TextFormField(
                
                validator:validator,
                controller: controller,
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
