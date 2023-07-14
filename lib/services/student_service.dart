import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_dashboard_app_tut/Models/student_class.dart';
import 'package:web_dashboard_app_tut/repositories/student_repository.dart';

class StudentService {
  final StudentRepository _repository;

  StudentService({StudentRepository? repository})
      : _repository = repository ?? StudentRepository();

  Stream<List<StudentInfo>> get studentList {
    return _repository.studentsRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }
}
