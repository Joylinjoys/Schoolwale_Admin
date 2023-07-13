// import 'package:flutter/material.dart';
//
// import '../screens/AnnouncementList.dart';
// import '../screens/Resultfirst.dart';
// import '../screens/RulesRegulation.dart';
// import '../screens/UploadNotes.dart';
// import '../screens/aboutschool.dart';
// import '../screens/addEvents.dart';
// import '../screens/navigation_screen.dart';
// import '../screens/studentList.dart';
// import '../screens/teachers.dart';
// import '../screens/timtable.dart';
//
// class NavigationRailWidget extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onDestinationSelected;
//
//   const NavigationRailWidget({
//     Key? key,
//     required this.selectedIndex,
//     required this.onDestinationSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return NavigationRail(
//       backgroundColor: Colors.deepPurple.shade400,
//       unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
//       unselectedLabelTextStyle: TextStyle(
//         color: Colors.white,
//       ),
//       selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade900),
//       destinations: [
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const DashboardScreen()),
//               );
//             },
//             child: Icon(Icons.dashboard),
//           ),
//           label: Text("Dashboard"),
//         ),
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Resultfirst ()),
//               );
//             },
//             child: Icon(Icons.bar_chart),
//           ),
//           label: Text("Results"),
//         ),
//
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const TeacherPage ()),
//               );
//             },
//             child: Icon(Icons.person),
//           ),
//           label: Text("Teachers"),
//         ),
//
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>const  Student_main()),
//               );
//
//
//             },
//             child: Icon(Icons.people_outline),
//           ),
//
//           label: Text("Students"),
//         ),
//         NavigationRailDestination(
//           icon: Icon(Icons.calendar_month_outlined),
//           label: Text("Attendance"),
//         ),
//
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AdminEvent ()),
//               );
//             },
//             child: Icon(Icons.celebration_outlined),
//           ),
//
//           label: Text("Events"),
//         ),
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>const AnnouncementsPage ()),
//               );
//
//
//             },
//             child: Icon(Icons.campaign),
//           ),
//
//           label: Text("Announcements"),
//         ),
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>const UploadNotes ()),
//               );
//
//
//             },
//             child: Icon(Icons.menu_book_outlined),
//           ),
//
//           label: Text("Upload Notes"),
//         ),
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>TimetableScreen()),
//               );
//             },
//             child: Icon(Icons.pending_actions_outlined),
//           ),
//           label: Text("TimeTable"),
//         ),
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>const SchoolDetails ()),
//               );
//             },
//             child: Icon(Icons.domain),
//           ),
//           label: Text("About School"),
//         ),
//         NavigationRailDestination(
//           icon: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  RulesRegulation ()),
//               );
//             },
//             child: Icon(Icons.rule_folder_outlined),
//           ),
//           label: Text("Rules and regulation"),
//         ),
//         // Add more navigation options here
//
//       ],
//       selectedIndex: selectedIndex,
//       onDestinationSelected: onDestinationSelected,
//     );
//   }
// }
