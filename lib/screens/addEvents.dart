import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/widgets/eventInput.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminEvent extends StatefulWidget {
  const AdminEvent({super.key});

  @override
  State<AdminEvent> createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
   final ImagePicker _picker = ImagePicker();

  File? _image;
   DateTime? _selectedDate;

   Future<void> _selectDate(BuildContext context) async {
     final DateTime? pickedDate = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime.now(),
       lastDate: DateTime(2100),
     );

     if (pickedDate != null && pickedDate != _selectedDate) {
       setState(() {
         _selectedDate = pickedDate;
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Events Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          //    controller: controller,
          
          child: Center(
            child: Container(
              
              width: 700,
              child: Column(
                children: [
               Text(
                  'Enter Event Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),

                // EventInput(
                //   hght: 200,
                //   label: "Enter event Id",
                //   hint: "Event Id",
                //   txt: "Enter Event Id",
                // ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                  'Enter Event name',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50),
                 SizedBox(
                     width: 250,
                    // height: 200,
                     child: TextField(
                        // controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Event name",
                          hintText: "enter event name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                   ),
                    
                  ],
                ),
                SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                  'Enter Date',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50),
                 SizedBox(
                     width: 250,
                    // height: 200,
                     child: TextField(
                       readOnly: true,
                       onTap: () => _selectDate(context),
                        // controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Enter Date",
                          hintText: "  DD | MM | YYYY  ",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                   ),
                    
                  ],
                ),
                 SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50),
                  SizedBox(
                    width: 250,
                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: _image == null
                                                ? Text('No image selected.')
                                                : Image.file(_image!),
                                          ),
                                          SizedBox(width: 10),
                                          SizedBox(
                                            width: 150,
                                            height: 47,
                                            child: ElevatedButton(
                                              child: Text('Upload Image'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .deepPurple, // Set button color to purple
                                              ),
                                              onPressed: () async {
                                                final image = await _picker.pickImage(
                                                    source: ImageSource.gallery);
                                                setState(() {
                                                  _image = image as File?;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                  ),
                    
                  ],
                ),
                 SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                  'Enter Description',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50),
                 SizedBox(
                     width: 250,
                 //  height: 500,
                     child: TextField(
                     // maxLines: 10,
                     maxLength: 200,
                        // controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "enter description",
                          border: OutlineInputBorder(),
                        ),
                      ),
                   ),
                    
                  ],
                ),
                    SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 140,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.deepPurple, // Set button color to purple
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
      
  
    );
  }
}
