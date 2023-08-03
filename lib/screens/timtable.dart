import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/addtimetabel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_network/image_network.dart';
// import 'package:cached_network_image/cached_network_image.dart';
class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Time Table',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Timetable List',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTimetable(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            height: 300.0,
            child: Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Timetable').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
          
                  if (!snapshot.hasData) {
                    return Center(child: Text('No Data Available'));
                  }
          
                  // Extract the documents from the snapshot
                  final documents = snapshot.data!.docs;
          
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // Extract the document data
                      final data = documents[index].data() as Map<String, dynamic>;
                      final className = documents[index].id;
                      final section = data['section'];
                      final imageUrl = data[className.substring(2)]['imageUrl'];
                  
                      return TimetableCard(
                        image: imageUrl,
                        text: '$className',
                        onDelete: () => _deleteTimetable(className),
                        onAddImage: () => _updateTimetableImage(className),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteTimetable(String className) {
    // Add your delete logic here
    print('Delete timetable for class: $className');
  }

  void _updateTimetableImage(String className) {
    // Add your image update logic here
    print('Update timetable image for class: $className');
  }
}

class TimetableCard extends StatelessWidget {
  final String? image; // Make the image field nullable
  final String text;
  final VoidCallback onDelete;
  final VoidCallback onAddImage;

  const TimetableCard({
    this.image, // Allow the image to be nullable
    required this.text,
    required this.onDelete,
    required this.onAddImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 200,
      child: Card(
        child: Column(
          children: [
          
            if (image != null)
             // Only show the image if it's not null
              Image.network(
                image!,
              //  imageCache: CachedNetworkImageProvider(image),
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    "   " +text,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.0),
                   
                      
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Timetable'),
                                    content: Text('Are you sure you want to delete?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the dialog
                                          onDelete(); // Call the delete function
                                        },
                                        child: Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the dialog
                                        },
                                        child: Text('No'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                            ),
                            child: Icon(Icons.delete),
                          ),
                        
                        // ElevatedButton(
                        //   onPressed: onAddImage,
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                        //   ),
                        //   child: Icon(Icons.add_a_photo),
                        // ),
                     
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

