import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_dashboard_app_tut/Models/student_class.dart';
import 'package:web_dashboard_app_tut/services/student_service.dart';

class StudentRepository {
  final FirebaseFirestore _firestore;

  StudentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<StudentInfo> get studentsRef =>
      _firestore.collection('Students').withConverter(
          fromFirestore: (snapshot, _) =>
              StudentInfo.fromJson(snapshot.data()!),
          toFirestore: (student, _) => student.toJson());
}
