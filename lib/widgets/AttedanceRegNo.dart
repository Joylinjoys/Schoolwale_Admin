import 'package:flutter/material.dart';
class RollNoContainer extends StatelessWidget {
  final String rollno;
  const RollNoContainer({super.key, required this.rollno});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Card(
        
        child: Container(
        
          width: 400,
          height:40,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
               rollno ,style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(10),
        //     topRight: Radius.circular(10),
        //     bottomLeft: Radius.circular(10),
        //     bottomRight: Radius.circular(10)
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
           // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        ),
        ),
      ),
    );
  }
}
