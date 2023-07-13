import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/widgets/AttedanceRegNo.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({super.key});

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {

  final _studentList = [
    '211901',
    '211902',
    '211903',
    '211904',
    '211905',
    '211906',
    '211907',
    '211908',
    '211909',
  ];

  final _absentees = [];

  @override
  Widget build(BuildContext context) {
    print('123');
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
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
             //   crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("Tap On Register Number",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                        const Text("List of present Students", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        Text("List of absentees", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                 ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                           const SizedBox(height: 20),
                         ..._studentList.map((student) =>  RollNoContainer(
                            rollno: student,
                            onTap: () {
                             setState(() {
                                _studentList.remove(student);
                                _absentees.add(student);
                             });
                            },
                          ))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                           SizedBox(height: 20),
                         ..._absentees.map((absent) =>  RollNoContainer(
                            rollno: absent,
                            onTap: () {
                              setState(() {
                                _absentees.remove(absent);
                                _studentList.add(absent);
                             });
                            },
                          ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
          //  ),
          ),
          
    );
  }
}