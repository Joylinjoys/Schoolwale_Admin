import 'package:flutter/material.dart';

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
                    // Handle Add button tap
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    children: [
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class I',
                        subtitle: 'Section A',
                        onDelete: () {  }, onAddImage: () {  },
                      ),
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class II',
                        subtitle: 'Section B',
                         onDelete: () {  }, onAddImage: () {  },
                      ),
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class III',
                        subtitle: 'Section A',
                        onDelete: () {  }, onAddImage: () {  },
                      ),
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class IV',
                        subtitle: 'Section B',
                         onDelete: () {  }, onAddImage: () {  },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    children: [
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class V',
                        subtitle: 'Section A',
                        onDelete: () {  }, onAddImage: () {  },
                      ),
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class VI',
                        subtitle: 'Section B',
                         onDelete: () {  }, onAddImage: () {  },
                      ),
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class VII',
                        subtitle: 'Section A',
                         onDelete: () {  }, onAddImage: () {  },
                      ),
                      TimetableCard(
                        image: 'https://images.twinkl.co.uk/tw1n/image/private/t_630/image_repo/fc/33/roi-pa-31-editable-sample-timetable_ver_2.jpg',
                        text: 'Class VIII',
                        subtitle: 'Section B',
                        onDelete: () {  }, onAddImage: () {  },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class TimetableCard extends StatelessWidget {
  final String image;
  final String text;
  final String subtitle;

  final VoidCallback onDelete;
  final VoidCallback onAddImage;

  const TimetableCard({
    required this.image,
    required this.text,
    required this.subtitle,
    required this.onDelete,
    required this.onAddImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 210,
      child: Card(
        child: Column(
          children: [
            Image.network(
              image,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      ElevatedButton(
                        onPressed: onAddImage,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                        ),
                        child: Icon(Icons.add_a_photo),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
