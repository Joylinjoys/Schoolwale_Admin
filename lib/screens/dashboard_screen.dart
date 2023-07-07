import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/aboutschool.dart';
import 'package:web_dashboard_app_tut/screens/teachers.dart';
import 'UploadNotes.dart';
import 'addEvents.dart';
import 'package:web_dashboard_app_tut/screens/timtable.dart';
import 'AnnouncementList.dart';
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
  bool isExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive breakpoint: When the available width is less than 500 pixels, show the navigation rail in a collapsed state
              final isSmallScreen = constraints.maxWidth < 500;
              final height = constraints.maxHeight < 500;

              return Expanded(

                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                          extended: !isSmallScreen && isExpanded,
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
                              MaterialPageRoute(builder: (context) => const TeacherPage ()),
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
                                   MaterialPageRoute(builder: (context) =>const  Student_main()),
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
                          icon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>const AnnouncementsPage ()),
                              );


                            },
                            child: Icon(Icons.campaign),
                          ),

                          label: Text("Announcements"),
                        ),
                        NavigationRailDestination(
                          icon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>const UploadNotes ()),
                              );


                            },
                            child: Icon(Icons.menu_book_outlined),
                          ),

                          label: Text("Upload Notes"),
                        ),
                        NavigationRailDestination(
                          icon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>TimetableScreen()),
                              );
                            },
                            child: Icon(Icons.pending_actions_outlined),
                          ),
                          label: Text("TimeTable"),
                        ),
                      NavigationRailDestination(
                        icon: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>const SchoolDetails ()),
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
                        // Add more navigation options here

                      ],
                      selectedIndex: 0,
                      onDestinationSelected: (int index) {
                        if (isSmallScreen) {
                          // Close the navigation rail when a destination is selected on small screens
                          setState(() {
                            isExpanded = false;
                          });
                        }
                          }
                      // },
                        ),
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQbh5cSiQvrbRD1wVsbv0L1hUolQIXgU6iTTdqsZf2pErDYjmUx1kCjXo_r_0TN_kMQ5c&usqp=CAU"),
                          radius: 28.0,
                        ),
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
    );
  }
}
