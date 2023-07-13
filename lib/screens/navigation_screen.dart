import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/aboutschool.dart';
import 'package:web_dashboard_app_tut/screens/teachers.dart';
import 'UploadNotes.dart';
import 'addEvents.dart';
import 'package:web_dashboard_app_tut/screens/timtable.dart';
import 'AnnouncementList.dart';
import 'Result.dart';
import 'RulesRegulation.dart';
import 'addclassList.dart';
import 'dashboard_screen.dart';
import 'eventList.dart';
import 'studentList.dart';
import 'Resultfirst.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  bool showNavigationBar = false;
  bool isExpanded = false;

  final _destinations = [
    DashboardScreen(),
    Resultfirst(),
    TeacherPage(),
    Student_main(),
    EventsPage(),
    AnnouncementsPage(),
    UploadNotes(),
    TimetableScreen(),
    SchoolDetails(),
    RulesRegulations()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {

              final isSmallScreen = constraints.maxWidth < 500;
              return Expanded(
                  child: SingleChildScrollView(
                  child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
              child: NavigationRail(
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                    extended: !isSmallScreen && isExpanded,
                    backgroundColor: Colors.deepPurple.shade400,
                    unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
                    unselectedLabelTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade900),
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard),
                        label: Text("Dashboard"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.bar_chart),
                        label: Text("Results"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person),
                        label: Text("Teachers"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.people_outline),
                        label: Text("Students"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.calendar_month_outlined),
                        label: Text("Attendance"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.celebration_outlined),
                        label: Text("Events"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.campaign),
                        label: Text("Announcements"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.menu_book_outlined),
                        label: Text("Upload Notes"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.pending_actions_outlined),
                        label: Text("TimeTable"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.domain),
                        label: Text("About School"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.rule_folder_outlined),
                        label: Text("Rules and regulation"),
                      ),
                      // Add more navigation options here
                    ],
                    selectedIndex: 0,
              ),
              ),
                  ),
                  ),
              );
            },
          ),
          Expanded(
            child: _destinations[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
