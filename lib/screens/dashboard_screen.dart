import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/Models/student_class.dart';
import 'package:web_dashboard_app_tut/repositories/student_repository.dart';
import 'package:web_dashboard_app_tut/screens/addclass.dart';
import 'package:web_dashboard_app_tut/services/student_service.dart';

import 'addclassList.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // int id = 20230001;
    // for (final student in students) {
    //   StudentRepository().studentsRef.doc(id.toString()).set(student);
    //   id++;
    // }
    super.initState();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   onPressed: () {
                //     setState(() {
                //       isExpanded = !isExpanded;
                //     });
                //   },
                //   // icon: Icon(Icons.menu),
                // ),
              ],
            ),
            SizedBox(
              height: 9.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 26.0,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Total Student",
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "500 Students",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_outlined,
                                size: 26.0,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                " Boys",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "250 Boys",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.woman,
                                size: 26.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Girls",
                                style: TextStyle(
                                  fontSize: 26.0,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "250 Girls",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 26.0,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Teacher",
                                style: TextStyle(
                                  fontSize: 26.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            " 56 Teachers",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => classfirst(),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 26.0,
                                  color: Colors.deepPurple,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  "classes",
                                  style: TextStyle(
                                    fontSize: 26.0,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Add Class",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Now let's set the article section
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
