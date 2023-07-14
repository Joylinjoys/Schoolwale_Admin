import 'package:flutter/material.dart';
import 'attendanceRegLIst.dart';
import 'package:intl/intl.dart';

class Attendancefirst extends StatefulWidget {
  const Attendancefirst({Key? key}) : super(key: key);
  

  @override
  _AttendancefirstState createState() => _AttendancefirstState();
}

class _AttendancefirstState extends State<Attendancefirst> {
  String? selectedClass;
  String? selectedSection;
  String? selectedRollNo;
  
  DateTime selectedDate = DateTime.now();
 // TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  List<String> classes = [
    'Class 1',
    'Class 2',
    'Class 3',
    // Add more class options here
  ];

  List<String> sections = [
    'Section A',
    'Section B',
    'Section C',
    // Add more section options here
  ];

  List<String> rollNos = [
    'Roll No 1',
    'Roll No 2',
    'Roll No 3',
    // Add more roll number options here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Attendance Page',
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
            child: Container(
              alignment: Alignment.topCenter,
              child: Container(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Select Class and Section',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Class:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: selectedClass,
                            onChanged: (newValue) {
                              setState(() {
                                selectedClass = newValue;
                              });
                            },
                            items: classes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            filled: true,
                            fillColor: Colors.white,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(8.0),
                            //   borderSide: BorderSide.none,
                            // ),
                            // contentPadding: EdgeInsets.symmetric(
                            //   vertical: 12.0,
                            //   horizontal: 16.0,
                            // ),
                            // suffixIcon: IconButton(
                            //   onPressed: () => _selectDate(context),
                            //   icon: Icon(Icons.calendar_today),
                            // ),
                          ),
                         // onTap: () => _selectDate(context),
                        ),
                      ),
                    
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Section:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: selectedSection,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSection = newValue;
                              });
                            },
                            items: sections.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            filled: true,
                            fillColor: Colors.white,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(8.0),
                            //   borderSide: BorderSide.none,
                            // ),
                            // contentPadding: EdgeInsets.symmetric(
                            //   vertical: 12.0,
                            //   horizontal: 16.0,
                            // ),
                            // suffixIcon: IconButton(
                            //   onPressed: () => _selectDate(context),
                            //   icon: Icon(Icons.calendar_today),
                            // ),
                          ),
                          //onTap: () => _selectDate(context),
                        ),
                      ),
                    
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                      Text(
                        'Enter Date:',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        width: 250,
                        child: TextFormField(
                          
                          readOnly: true,
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(selectedDate),
                          ),
                          decoration: InputDecoration(
                             border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            filled: true,
                            fillColor: Colors.white12,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(8.0),
                            //   borderSide: BorderSide.none,
                            // ),
                            // contentPadding: EdgeInsets.symmetric(
                            //   vertical: 12.0,
                            //   horizontal: 16.0,
                            // ),
                            suffixIcon: IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today),
                            ),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Select Roll No:',
                    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    //     ),
                    //     SizedBox(width: 8),
                    //     Container(
                    //       width: 250,
                    //       child: DropdownButtonFormField<String>(
                    //         value: selectedRollNo,
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             selectedRollNo = newValue;
                    //           });
                    //         },
                    //         items: rollNos.map<DropdownMenuItem<String>>((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Text(value),
                    //           );
                    //         }).toList(),
                    //         decoration: InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                     SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AttendanceList()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: Size(200, 50),
                        ),
                        child: Text(
                          'Submit',
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
    );
  }
}
