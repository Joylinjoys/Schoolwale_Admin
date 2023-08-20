import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_dashboard_app_tut/Models/student_class.dart';
import 'package:web_dashboard_app_tut/widgets/AttedanceRegNo.dart';
import '../services/student_service.dart';
import 'attedanceStream.dart';

class AttendanceList extends StatefulWidget {
  final String className;
  final String sectionName;
  final DateTime selectedDate;
  const AttendanceList(
      {super.key,
      required this.className,
      required this.sectionName,
      required this.selectedDate});

  @override
  State<AttendanceList> createState() =>
      _AttendanceListState(className, sectionName, selectedDate);
}

class _AttendanceListState extends State<AttendanceList> {
  late final String className;
  late final String sectionName;
  late final DateTime selectedDate;

  _AttendanceListState(this.className, this.sectionName, this.selectedDate);

  final List<StudentInfo> _studentList = [];

  final List<StudentInfo> _absentees = [];
  List<String> registerNumbers = [];
  @override
  void initState() {
    //print(widget.className);
    super.initState();
  }

  void getAbsentees(List<StudentInfo> absentees) {
    for (int i = 0; i < absentees.length; i++) {
      registerNumbers.add(absentees[i].registerNumber);
    }
  }

  void submitAttendanc() {
    String date = new DateFormat('dd-MM-yyyy').format(selectedDate);

    print(date); //19-08-2023

    print(selectedDate); //2023-08-19 12:17:04.791
  }

  Future<void> submitAttendance() async {
    String date = new DateFormat('dd-MM-yyyy').format(selectedDate);
    // date =19-08-2023 -format

    try {
      await FirebaseFirestore.instance.collection('Attendance').doc(date).set({
        'date': date,
        'absentees': registerNumbers,
      });

      //resetting the list
      registerNumbers = [];
      // Show success message dialog
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Attendance updated successfully.",
        width: MediaQuery.of(context).size.width / 5,
      );
    } catch (e) {
      print('Error updating attendance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // body:
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
              StreamBuilder(
                  stream: StudentService().studentList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<StudentInfo>> snapshot) {
                    if (snapshot.hasError ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      print(snapshot.error);
                      print("dddddw");
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          strokeWidth: 6,
                        ),
                      );
                    }
                    final documents = snapshot.data ?? [];
                    _studentList.addAll(documents
                        .where((element) =>
                            element.className == widget.className &&
                            element.sectionName == widget.sectionName)
                        .toList());

                    return StatefulBuilder(builder: (context, setState) {
                      return Row(
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
                      );
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    getAbsentees(_absentees);
                    print(registerNumbers);

                    submitAttendance();
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
