import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/Models/student_class.dart';
import 'package:web_dashboard_app_tut/widgets/AttedanceRegNo.dart';
import '../services/student_service.dart';
import 'attedanceStream.dart';

class AttendanceList extends StatefulWidget {
  final String className;
  final String sectionName;
  const AttendanceList(
      {super.key, required this.className, required this.sectionName});

  @override
  State<AttendanceList> createState() =>
      _AttendanceListState(className, sectionName);
}

class _AttendanceListState extends State<AttendanceList> {
  late final String className;
  late final String sectionName;

  _AttendanceListState(this.className, this.sectionName);

  final List<StudentInfo> _studentList = [];

  final List<StudentInfo> _absentees = [];

  @override
  void initState() {
    List<StudentInfo> documents = [];
    StreamBuilder(
      stream: StudentService().studentList,
      builder:
          (BuildContext context, AsyncSnapshot<List<StudentInfo>> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          print(snapshot.error);
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
              strokeWidth: 6,
            ),
          );
        }
        documents = snapshot.data ?? [];
        print(documents);
        print("hjdhjahjhdajh");
        return Text(" dsfdsfsd");
      },
    );

    _studentList.addAll(documents
        .where((element) =>
            element.className == widget.className &&
            element.sectionName == widget.sectionName)
        .toList());
    print(_studentList);
    print(widget.className);
    //print(widget.className);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // body:StreamBuilder(
    //   stream: StudentService().studentList,
    //   builder:
    //       (BuildContext context, AsyncSnapshot<List<StudentInfo>> snapshot) {
    //     if (snapshot.hasError ||
    //         snapshot.connectionState == ConnectionState.waiting) {
    //       print(snapshot.error);
    //       return Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.red,
    //           strokeWidth: 6,
    //         ),
    //       );
    //     }
    //     final documents = snapshot.data ?? [];
    //       final List<StudentInfo> students=[];
    //final List<String> studentList=[];

    //  for (var val in documents) {
    //   final obj= StudentInfo.fromJson(val);
    //   students.add(obj);

    // }
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Tap On Register Number",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "List of present Students",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "List of absentees",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
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
                      ..._studentList.map((student) => RollNoContainer(
                            rollno: student.registerNumber.toString(),
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
                      ..._absentees.map((absent) => RollNoContainer(
                            rollno: absent.registerNumber.toString(),
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AttendanceList()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //  ),
        ),
      ),
    );
    //   },

    //   ),

    // );
  }
}
