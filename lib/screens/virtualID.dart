
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/Models/class_and_section.dart';
import 'package:web_dashboard_app_tut/screens/Result.dart';
import 'package:image_picker/image_picker.dart';

class VirtualId extends StatefulWidget {
   const VirtualId({super.key});

  @override
   State<VirtualId> createState() => _VirtualIdState();
 }

 class _VirtualIdState extends State<VirtualId> {
   final ImagePicker _picker = ImagePicker();

   //File? _image;
   String? selectedClass;
   String? selectedSection;
   String? selectedRollNo;
   String? selectedClassSection;

   final sectionStream = StreamController<List<String>>();
   bool ischange = false;
   final _formKey = GlobalKey<FormState>();

   get textFieldWidth => null;

   Future<void> _submitForm() async {
     if (_formKey.currentState!.validate()) {
       // Form is valid, navigate to the next page
       Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) =>
                 ResultPage(
                   regNo: selectedRollNo.toString(),
                 )),
       );
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text(
           'View Virtual ID',
           style: TextStyle(
             fontSize: 29,
             fontWeight: FontWeight.bold,
           ),
         ),
         backgroundColor: Colors.deepPurple.shade400,
       ),
       body: SingleChildScrollView(
         child: Center(
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Form(
               key: _formKey,
               child: Container(
                 alignment: Alignment.topCenter,
                 child: Container(
                   width: 500,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Center(
                         child: Text(
                           'Enter Student Virtual ID',
                           style: TextStyle(
                               fontSize: 24, fontWeight: FontWeight.bold),
                         ),
                       ),
                       SizedBox(height: 16),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             'Select Class:',
                             style: TextStyle(
                                 fontSize: 18, fontWeight: FontWeight.bold),
                           ),
                           SizedBox(width: 8),
                           Container(
                             width: 250,
                             child: StreamBuilder(
                                 stream: FirebaseFirestore.instance
                                     .collection("ClassSections")
                                     .snapshots(),
                                 builder: (BuildContext context,
                                     AsyncSnapshot<dynamic> snapshot) {
                                   if (snapshot.hasError ||
                                       snapshot.connectionState ==
                                           ConnectionState.waiting) {
                                     return Text("Loading");
                                   }

                                   // final classData = snapshot.data ?? [];
                                   final List<String> classData = [];
                                   final documents = snapshot.data!.docs.map((
                                       e) {
                                     classData.add(e.id);
                                     return e.data();
                                   });

                                   final List<Sections> sectionList = [];

                                   for (var val in documents) {
                                     final object = Sections.fromJson(val);

                                     sectionList.add(object);
                                   }

                                   return DropdownButtonFormField<String>(
                                     value: selectedClass,
                                     onChanged: (newValue) {
                                       setState(() {
                                         //sectionStream.add([]);
                                         selectedClass = newValue;
                                         List<String> section = sectionList[
                                         (int.parse(selectedClass!)) - 1]
                                             .sections
                                             .cast<String>()
                                             .toList();

                                         sectionStream.add(section);
                                         ischange = true;
                                       });
                                     },
                                     //items=classData
                                     items: classData
                                         .map<DropdownMenuItem<String>>(
                                             (String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(value),
                                           );
                                         }).toList(),
                                     validator: (value) {
                                       if (value == null) {
                                         return 'please select a class';
                                       }
                                       return null;
                                     },
                                     decoration: InputDecoration(
                                       border: OutlineInputBorder(),
                                       contentPadding: EdgeInsets.symmetric(
                                           vertical: 8, horizontal: 4),
                                     ),
                                   );
                                 }),
                           ),
                         ],
                       ),
                       SizedBox(height: 16),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             'Select Section:',
                             style: TextStyle(
                                 fontSize: 18, fontWeight: FontWeight.bold),
                           ),
                           SizedBox(width: 8),
                           Container(
                             width: 250,
                             child: StreamBuilder(
                                 stream: sectionStream.stream,
                                 builder: (BuildContext context,
                                     AsyncSnapshot<List<String>> snapshot) {
                                   if (snapshot.connectionState ==
                                       ConnectionState.waiting) {
                                     return Text('Loading...');
                                   }

                                   final sections = snapshot.data ?? [];

                                   return DropdownButtonFormField<String>(
                                     value: selectedSection,
                                     onChanged: (newValue) {
                                       setState(() {
                                         selectedSection = newValue;
                                         selectedClassSection = selectedClass! +
                                             " " +
                                             selectedSection!;
                                       });
                                     },
                                     items: sections.map<
                                         DropdownMenuItem<String>>(
                                             (String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(value),
                                           );
                                         }).toList(),
                                     validator: (value) {
                                       if (value == null) {
                                         return 'please select a section';
                                       }
                                       return null;
                                     },
                                     decoration: InputDecoration(
                                       border: OutlineInputBorder(),
                                       contentPadding: EdgeInsets.symmetric(
                                           vertical: 8, horizontal: 4),
                                     ),
                                   );
                                 }),
                           ),
                         ],
                       ),
                       SizedBox(height: 16),
                       // Row(
                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       //   children: [
                       //     Text(
                       //       'Select Roll No:',
                       //       style: TextStyle(
                       //           fontSize: 18, fontWeight: FontWeight.bold),
                       //     ),
                       //     SizedBox(width: 8),
                       //     Container(
                       //       width: 250,
                       //       child: StreamBuilder(
                       //           stream: FirebaseFirestore.instance
                       //               .collection("Students")
                       //               .where('Class', isEqualTo: selectedClass)
                       //               .where(
                       //               'Section', isEqualTo: selectedSection)
                       //               .snapshots(),
                       //           builder: (BuildContext context,
                       //               AsyncSnapshot<dynamic> snapshot) {
                       //             if (snapshot.hasError ||
                       //                 snapshot.connectionState ==
                       //                     ConnectionState.waiting) {
                       //               return Text("Loading");
                       //             }
                       //             List<String> lss = [];
                       //             final documents = snapshot.data!.docs.map((
                       //                 e) {
                       //               lss.add(e.id.toString());
                       //               return e.data();
                       //             });
                       //             //dont remove below line
                       //             documents.toString();
                       //             //print(lss);
                       //
                       //             return DropdownButtonFormField<String>(
                       //               value: selectedRollNo,
                       //               onChanged: (newValue) {
                       //                 setState(() {
                       //                   selectedRollNo = newValue;
                       //                 });
                       //               },
                       //               items: lss.map<DropdownMenuItem<String>>(
                       //                       (String value) {
                       //                     return DropdownMenuItem<String>(
                       //                       value: value,
                       //                       child: Text(value),
                       //                     );
                       //                   }).toList(),
                       //               validator: (value) {
                       //                 if (value == null) {
                       //                   return 'please select a roll number';
                       //                 }
                       //                 return null;
                       //               },
                       //               decoration: InputDecoration(
                       //                 border: OutlineInputBorder(),
                       //                 contentPadding: EdgeInsets.symmetric(
                       //                     vertical: 8, horizontal: 4),
                       //               ),
                       //             );
                       //           }),
                       //     ),
                       //   ],
                       // ),


                       SizedBox(height: 40),

                       // Container(
                       //   width: textFieldWidth,
                       //   // height:200,
                       //   child: Row(
                       //     mainAxisAlignment: MainAxisAlignment.center,
                       //     children: [
                       //       Flexible(
                       //         child: _image == null
                       //             ? Text('No image selected.')
                       //             : Image.file(_image!),
                       //       ),
                       //       SizedBox(width: 10),
                       //       SizedBox(
                       //         width: 150,
                       //         height: 47,
                       //         child: ElevatedButton(
                       //           child: Text('Upload Image'),
                       //           style: ElevatedButton.styleFrom(
                       //             primary: Colors
                       //                 .deepPurple, // Set button color to purple
                       //           ),
                       //           onPressed: () async {
                       //             final image = await _picker.pickImage(
                       //                 source: ImageSource.gallery);
                       //             setState(() {
                       //               _image = image as File?;
                       //             });
                       //           },
                       //         ),
                       //       ),
                       //     ],
                       //   ),
                       //
                       // ),
                       SizedBox(
                         height: 50,
                       ),
                          Center(
                         child: ElevatedButton(
                           onPressed: _submitForm,
                           style: ElevatedButton.styleFrom(
                             primary: Colors.deepPurple,
                             minimumSize: Size(200, 50),
                           ),
                           child: Text(
                             'Add',
                             style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ),


                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),
       ),
     );
   }
 }
// class DATA {}
