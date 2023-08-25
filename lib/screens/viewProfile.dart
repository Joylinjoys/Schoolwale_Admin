import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/profilepage_converter.dart';

class ViewStudent extends StatefulWidget {
  final String regNo;
  const ViewStudent({Key? key, required this.regNo}) : super(key: key);

  @override
  State<ViewStudent> createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: Text(
              'View Student details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.deepPurple.shade400,
          ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection("Students").
          doc(widget.regNo)
             .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text("No data available");
          }

          final data = snapshot.data!;
          if (data == null) {
            return Text("No data available");
          }

          final profileData = ProfileConverter.fromJson(data.data()!);

          return ProfilePageContent(profileData: profileData);

        },
      ),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  final ProfileConverter profileData;

  const ProfilePageContent({Key? key, required this.profileData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String studentclass;
    print(profileData.profileImageUrl);
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Card(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 750,
              width: 550,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(profileData.profileImageUrl.toString()),
                  ),
                  SizedBox(height: 16),
                  Text(profileData.name ?? ''),
                  SizedBox(height: 8),
                  Text(profileData.grade! + profileData.section.toString() ?? ''),
                  SizedBox(height: 8),
                  Text(profileData.rollNumber != null
                      ? profileData.rollNumber.toString()
                      : ''),
                  SizedBox(height: 16),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(8),
                    color:  Color.fromARGB(255, 236, 229, 246),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.school,
                            color: Colors.deepPurple.shade400,
                          ),
                          title: Text('School Name'),
                          subtitle: Text(profileData.schoolName ?? ''),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.boy,
                            color: Colors.deepPurple.shade400,
                          ),
                          title: Text('Gender'),
                          subtitle: Text(profileData.gender ?? ''),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.cake_outlined,
                            color: Colors.deepPurple.shade400,
                          ),
                          title: Text('Date of Birth'),
                          subtitle: Text(profileData.dateOfBirth ?? ''),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color:  Colors.deepPurple.shade400,
                          ),
                          title: Text('Fathers Name'),
                          subtitle: Text(profileData.fathersName ?? ''),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.girl,
                            color:  Colors.deepPurple.shade400,
                          ),
                          title: Text('Mothers Name'),
                          subtitle: Text(profileData.mothersName ?? ''),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.deepPurple.shade400,
                          ),
                          title: Text('Phone No'),
                          subtitle: Text(profileData.phoneNo != null
                              ? profileData.phoneNo.toString()
                              : ''),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_city_outlined,
                            color: Colors.deepPurple.shade400,
                          ),
                          title: Text('Address'),
                          subtitle: Text(profileData.address ?? ''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}