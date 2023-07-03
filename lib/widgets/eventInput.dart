import 'package:flutter/material.dart';
class EventInput extends StatelessWidget {
 final String txt;
  final double hght;
 final String label;
  final String hint;

  const EventInput({super.key, required this.txt, required this.hght, required this.label, required this.hint});
 

  @override
  Widget build(BuildContext context) {
    return Row(
       mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
             txt,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 50),
             SizedBox(
                 width: 250,
                height: hght,
                 child: TextField(
                    // controller: nameController,
                    decoration: InputDecoration(
                      labelText: label,
                      hintText: hint,
                      border: OutlineInputBorder(),
                    ),
                  ),
               ),
        
              ],
    );
  }
}