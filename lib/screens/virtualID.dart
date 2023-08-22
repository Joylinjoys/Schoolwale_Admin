// import 'dart:io';

// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:cloud_firestore/cloud_firestore.dart';

// class VirtualId extends StatefulWidget {
//   const VirtualId({Key? key}) : super(key: key);

//   @override
//   _VirtualIdState createState() => _VirtualIdState();
// }

// class _VirtualIdState extends State<VirtualId> {
//   File? _image;
//   PlatformFile? _platformFile;
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController _selectClassController = TextEditingController();
//   TextEditingController _selectSectionController = TextEditingController();
//   TextEditingController _selectRollNoController = TextEditingController();

//   String? _validateImage(PlatformFile? file) {
//     if (file == null) {
//       return 'Please select an image';
//     }
//     return null;
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       // Form validation passed, handle form submission
//       if (_platformFile != null) {
//         // Generate a unique filename
//         String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
//         firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);

//         if (kIsWeb) {
//           // Upload the file data
//           await ref.putData(_platformFile!.bytes!);
//         } else {
//           // Upload the file
//           await ref.putFile(File(_platformFile!.path!));
//         }

//         // Get the download URL of the uploaded image
//         String downloadUrl = await ref.getDownloadURL();

//         // Store the virtual ID details in Firestore
//         await FirebaseFirestore.instance.collection('Students').doc(_selectRollNoController.text).set({
//           'class': _selectClassController.text,
//           'section': _selectSectionController.text,
//           'rollNo': _selectRollNoController.text,
//           'virtualIdUrl': downloadUrl,
//         });

//         // Show the CoolAlert after successful submission
//         CoolAlert.show(
//           context: context,
//           type: CoolAlertType.success,
//           text: "Virtual ID details submitted successfully!",
//           width: MediaQuery.of(context).size.width / 5,
//         );

//         // Reset the form and clear the file
//         _formKey.currentState!.reset();
//         setState(() {
//           _platformFile = null;
//         });
//       }
//     }
//   }

//   Future<void> _selectImage() async {
//     if (kIsWeb) {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           _platformFile = result.files.first;
//         });
//       }
//     } else {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           _platformFile = result.files.first;
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _selectClassController.dispose();
//     _selectSectionController.dispose();
//     _selectRollNoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Virtual ID Details',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.deepPurple.shade400,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Container(
//               width: 700,
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 20),
//                     Text(
//                       'Virtual ID Details',
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Select Class',
//                           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 50),
//                         SizedBox(
//                           width: 250,
//                           child: TextFormField(
//                             controller: _selectClassController,
//                             decoration: InputDecoration(
//                               labelText: "Select Class",
//                               hintText: "Enter Class",
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Select Section',
//                           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 50),
//                         SizedBox(
//                           width: 250,
//                           child: TextFormField(
//                             controller: _selectSectionController,
//                             decoration: InputDecoration(
//                               labelText: "Select Section",
//                               hintText: "Enter Section",
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Select Roll No',
//                           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 50),
//                         SizedBox(
//                           width: 250,
//                           child: TextFormField(
//                             controller: _selectRollNoController,
//                             decoration: InputDecoration(
//                               labelText: "Select Roll No",
//                               hintText: "Enter Roll No",
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Upload Image',
//                           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 50),
//                         SizedBox(
//                           width: 250,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 90,
//                                 width: 90,
//                                 child: _platformFile == null
//                                     ? Text('No image selected.')
//                                     : Text(_platformFile?.name ?? 'No name'),
//                               ),
//                               SizedBox(width: 10),
//                               SizedBox(
//                                 width: 150,
//                                 height: 47,
//                                 child: ElevatedButton(
//                                   child: Text('Select Image'),
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Colors.deepPurple,
//                                   ),
//                                   onPressed: _selectImage,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.deepPurple,
//                           minimumSize: Size(200, 50),
//                         ),
//                         child: Text(
//                           'Submit',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_view/photo_view.dart';
class VirtualId extends StatefulWidget {
  final String regNo;
  const VirtualId({super.key, required this.regNo});

  @override
  State<VirtualId> createState() => _VirtualIdState(regNo);
}

class _VirtualIdState extends State<VirtualId> {
  final String regNo;
  _VirtualIdState( this.regNo);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Virtual ID',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.deepPurple.shade400,
          ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection("Students")
            .where(regNo)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data();
          final imageUrl = (data?['virtualIdUrl']) as String;

          return ListView(
            children: [
              Card(
                child: Column(
                  children: [
                    Container(
                      height: ((MediaQuery.of(context).size.height) / 10) * 7,
                      width: ((MediaQuery.of(context).size.width) / 10) * 10,
                      child: PhotoView(
                        imageProvider: NetworkImage(imageUrl),
                        minScale: PhotoViewComputedScale.contained * 0.9,
                        maxScale: PhotoViewComputedScale.covered * 8,
                        backgroundDecoration: BoxDecoration(
                          color: Colors.white, // Set the background color here
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Text(
                    //     'Virtual ID Card',
                    //     style: TextStyle(fontSize: 20.0),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
