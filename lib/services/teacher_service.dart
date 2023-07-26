import 'package:web_dashboard_app_tut/Models/teachers_class.dart';

import 'package:web_dashboard_app_tut/repositories/teacher_repository.dart';

class TeacherService {
  final _repository;

  TeacherService({TeacherRepository? repository})
      : _repository = repository ?? TeacherRepository();

  Stream<List<TeacherInfo>> get teacherList {
    return _repository.teachersRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }
}
