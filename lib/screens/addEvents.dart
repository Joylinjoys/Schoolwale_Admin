import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminEvent extends StatefulWidget {
  const AdminEvent({Key? key}) : super(key: key);

  @override
  State<AdminEvent> createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  PlatformFile? _platformFile;

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

  Future<void> _selectImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _platformFile = result.files.first;
        });
      }
    } else {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image as File?;
      });
    }
  }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form validation passed, handle form submission
      if (_image != null || _platformFile != null) {
        // Generate a custom document ID using the current timestamp
        String customDocumentId = DateTime.now().millisecondsSinceEpoch.toString();

        // Generate a unique filename for the image
        String fileName = customDocumentId + '.jpg';
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);

        if (kIsWeb && _platformFile != null) {
          // Upload the file data (for web)
          await ref.putData(_platformFile!.bytes!);
        } else if (_image != null) {
          // Upload the file (for mobile)
          await ref.putFile(_image!);
        }

        // Get the download URL of the uploaded image
        String downloadUrl = await ref.getDownloadURL();

        // Store the event details in Firestore with the custom document ID
        await FirebaseFirestore.instance.collection('Event').doc(customDocumentId).set({
          'eventName': _eventNameController.text,
          'eventDate': _selectedDate,
          'imageUrl': downloadUrl,
          'description': _descriptionController.text,
        });

        // Reset the form and clear the file
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _platformFile = null;
        });

        // Show success alert using CoolAlert
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Event added successfully!",
          width: MediaQuery.of(context).size.width / 5,
          onConfirmBtnTap: () {
            // After the user confirms the alert, do any further actions (if needed)
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                          'Enter Date',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            readOnly: true, // Prevent manual text input
                            controller: TextEditingController(
                              text: _selectedDate != null ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' : '',
                            ),
                            onTap: () => _selectDate(context), // Show date picker on tap
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Date",
                              hintText: "Enter Date",
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
                                child: kIsWeb
                                    ? SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: _platformFile == null
                                      ? Text('No image selected.')
                                      : Text(_platformFile?.name ?? 'No name'),
                                )
                                    : _image == null
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
                              if (
value!.isEmpty) {
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
                          'Submit',
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
