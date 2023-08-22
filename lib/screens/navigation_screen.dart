import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/aboutschool.dart';
import 'package:web_dashboard_app_tut/screens/attedanceFirst.dart';
import 'package:web_dashboard_app_tut/screens/teachers.dart';
import 'package:web_dashboard_app_tut/screens/virtualID.dart';
import 'UploadNotes.dart';
import 'package:web_dashboard_app_tut/screens/timtable.dart';
import 'AnnouncementList.dart';
import 'RulesRegulation.dart';
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
    // VirtualId(),
    Attendancefirst(),
    EventsPage(),
    AnnouncementsPage(),
    UploadNotes(),
    TimetableScreen(),
    SchoolDetails(),
    RulesRegulation()

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
                            icon: Tooltip(
                              message: 'Dashboard',
                              child: Icon(Icons.dashboard),
                            ),
                            selectedIcon: Tooltip(
                              message: 'Dashboard',
                              child: Icon(Icons.dashboard),
                            ),
                            label: Text('Dashboard'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Results',
                              child: Icon(Icons.bar_chart),
                            ),
                            selectedIcon: Tooltip(
                              message: 'Results',
                              child: Icon(Icons.bar_chart),
                            ),
                            label: Text('Results'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Teachers',
                              child: Icon(Icons.person),
                            ),
                            label: Text('Teachers'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Students',
                              child: Icon(Icons.people_outline),
                            ),
                            label: Text('Students'),
                          ),
                          // NavigationRailDestination(
                          //   icon: Tooltip(
                          //     message: 'Virtual ID',
                          //     child: Icon(Icons.person_pin_outlined),
                          //   ),
                          //   label: Text('Virtual ID'),
                          // ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Attendance',
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            label: Text('Attendance'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Events',
                              child: Icon(Icons.celebration_outlined),
                            ),
                            label: Text('Events'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Announcements',
                              child: Icon(Icons.campaign),
                            ),
                            label: Text('Announcements'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Upload Notes',
                              child: Icon(Icons.menu_book_outlined),
                            ),
                            label: Text('Upload Notes'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'TimeTable',
                              child: Icon(Icons.pending_actions_outlined),
                            ),
                            label: Text('TimeTable'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'About School',
                              child: Icon(Icons.domain),
                            ),
                            label: Text('About School'),
                          ),
                          NavigationRailDestination(
                            icon: Tooltip(
                              message: 'Rules and regulation',
                              child: Icon(Icons.rule_folder_outlined),
                            ),
                            label: Text('Rules and regulation'),
                          ),
                          // Add more navigation options here
                        ],
                        selectedIndex: _selectedIndex,
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
