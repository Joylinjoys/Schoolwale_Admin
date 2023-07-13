import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/widgets/AttedanceRegNo.dart';
class AttendanceList extends StatelessWidget {
  const AttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Register Numbers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.deepPurple.shade400,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),

           // child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("List of students", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                       SizedBox(height: 20),
                      RollNoContainer(
                        rollno: "211901"
                      ),
                     // SizedBox(height: 10),
                      RollNoContainer(
                        rollno: "211902"
                      ),
                       RollNoContainer(
                        rollno: "211903"
                      ),
                   //   SizedBox(height: 10),
                      RollNoContainer(
                        rollno: "211904"
                      ),
                       RollNoContainer(
                        rollno: "211905"
                      ),
                    //  SizedBox(height: 10),
                      RollNoContainer(
                        rollno: "211906"
                      ),
                       RollNoContainer(
                        rollno: "211907"
                      ),
                     // SizedBox(height: 10),
                      RollNoContainer(
                        rollno: "211908"
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("List of absentees", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                       SizedBox(height: 20),
                     
                    ],
                  ),
                ],
              ),
          //  ),
          ),
    );
  }
}