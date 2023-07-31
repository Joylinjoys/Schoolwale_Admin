import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class EditEvent extends StatefulWidget {
  final Map<String, dynamic> eventData;

  const EditEvent({Key? key, required this.eventData}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the initial values of the form fields with the event data
    _eventNameController.text = widget.eventData['eventName'] ?? '';
    _selectedDate = widget.eventData['eventDate'].toDate();
    _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
    _descriptionController.text = widget.eventData['description'] ?? '';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(pickedDateTime.year, pickedDateTime.month, pickedDateTime.day, pickedTime.hour, pickedTime.minute);
          _selectedTime = pickedTime;
        });
      }
    }
  }

  Future<void> _selectImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File?;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form validation passed, handle form submission
      if (_image != null) {
        // Generate a unique filename
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);

        // Upload the file
        await ref.putFile(_image!);

        // Get the download URL of the uploaded image
        String downloadUrl = await ref.getDownloadURL();

        // Update the event details in Firestore with the image URL
        await FirebaseFirestore.instance.collection('Event').doc(widget.eventData['eventId']).update({
          'eventName': _eventNameController.text,
          'eventDate': _selectedDate,
          'description': _descriptionController.text,
          'imageUrl': downloadUrl,
        });

        // Show success CoolAlert
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Event updated successfully!",
          onConfirmBtnTap: () {
            // Return the updated event data to the calling page (EventsPage)
            Navigator.pop(
              context,
              {
                'eventName': _eventNameController.text,
                'eventDate': _selectedDate,
                'description': _descriptionController.text,
                'imageUrl': downloadUrl,
              },
            );
          },
        );
      } else {
        // If no new image selected, only update the other event details in Firestore
        await FirebaseFirestore.instance.collection('Event').doc(widget.eventData['eventId']).update({
          'eventName': _eventNameController.text,
          'eventDate': _selectedDate,
          'description': _descriptionController.text,
        });

        // Show success CoolAlert
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Event updated successfully!",
          onConfirmBtnTap: () {
            // Return the updated event data to the calling page (EventsPage)
            Navigator.pop(
              context,
              {
                'eventName': _eventNameController.text,
                'eventDate': _selectedDate,
                'description': _descriptionController.text,
              },
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Event',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 700,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Enter Event Details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter Event Name',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _eventNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an event name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Event Name",
                              hintText: "Enter Event Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Date and Time',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            readOnly: true, // Prevent manual text input
                            controller: TextEditingController(
                              text: _selectedDate != null && _selectedTime != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} ${_selectedTime!.format(context)}'
                                  : '',
                            ),
                            onTap: () => _selectDateTime(context), // Show date and time picker on tap
                            validator: (value) {
                              if (_selectedDate == null || _selectedTime == null) {
                                return 'Please select a date and time';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Date and Time",
                              hintText: "Select Date and Time",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                                  child: Text('Select Image'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple,
                                  ),
                                  onPressed: _selectImage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                          child: TextFormField(
                            maxLines: 4,
                            maxLength: 200,
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Description",
                              hintText: "Enter Description",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 140,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Edit',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
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
    );
  }
}
