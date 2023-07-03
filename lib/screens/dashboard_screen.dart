import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/aboutschool.dart';
import 'package:web_dashboard_app_tut/screens/teachers.dart';
import 'addEvents.dart';

import 'Result.dart';
import 'RulesRegulation.dart';
import 'studentList.dart';
import 'Resultfirst.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //setting the expansion function for the navigation rail
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Row(
        children: [

          NavigationRail(
              extended: isExpanded,
              backgroundColor: Colors.deepPurple.shade400,
              unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: TextStyle(
                color: Colors.white,
              ),
              selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade900),
              destinations: [
                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DashboardScreen()),
                      );
                    },
                    child: Icon(Icons.dashboard),
                  ),
                  label: Text("Dashboard"),
                ),

                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Resultfirst ()),
                      );
                    },
                    child: Icon(Icons.bar_chart),
                  ),
                  label: Text("Results"),
                ),

                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const  TeacherPage ()),
                      );
                    },
                    child: Icon(Icons.person),
                  ),
                  label: Text("Teachers"),
                ),

                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Student_main ()),
                      );
                    },
                    child: Icon(Icons.people_outline),
                  ),

                  label: Text("Students"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: Text("Attendance"),
                ),
                // NavigationRailDestination(
                //   icon: Icon(Icons.celebration_outlined),
                //   label: Text("Events"),
                // ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminEvent ()),
                      );
                    },
                    child: Icon(Icons.celebration_outlined),
                  ),

                  label: Text("Events"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.campaign_outlined),
                  label: Text("Annoucements"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.pending_actions_outlined),
                  label: Text("Timetable"),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CollegeDetails ()),
                      );
                    },
                    child: Icon(Icons.domain),
                  ),
                  label: Text("About School"),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  RulesRegulation ()),
                      );
                    },
                    child: Icon(Icons.rule_folder_outlined),
                  ),
                  label: Text("Rules and regulation"),
                ),
              ],
              selectedIndex: 0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(60.0),
              // child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //let's add the navigation menu for this project
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //let's trigger the navigation expansion
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREgU4XUc2HEmT28R4cbmxLFcmPRIvmF0WUEMRztghFhxw_FKXUiJi7CNrVUmEt6NUfbUY&usqp=CAU"),
                          radius: 28.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9.0,
                    ),
                    //Now let's start with the dashboard main rapports
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
                                    "967 Students",
                                    style: TextStyle(
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
                                        Icons.person_outlined,
                                        size: 26.0,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        " Total boys 179",
                                        style: TextStyle(
                                          color: Colors.lightBlueAccent,
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
                                    "boys",
                                    style: TextStyle(
                                      color: Colors.red,
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
                                    "Total girls 267",
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
                                    " 56 teachers",
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
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
            ),

        ],
      ),
      //let's add the floating action button

    );
  }
}
