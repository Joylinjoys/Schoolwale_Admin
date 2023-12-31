import 'package:flutter/material.dart';

import 'package:web_dashboard_app_tut/screens/navigation_screen.dart';
//import 'package:web_dashboard_app_tut/screens/studentList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Text("get lost",style: TextStyle(color: Colors.green),),
     home: NavigationScreen(),
    );
  }
}
