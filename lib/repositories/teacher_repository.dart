import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/teachers_class.dart';

class TeacherRepository {
  final FirebaseFirestore _firestore;

  TeacherRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<TeacherInfo> get teachersRef =>
      _firestore.collection('Teachers').withConverter(
          fromFirestore: (snapshot, _) =>
              TeacherInfo.fromJson(snapshot.data()!),
          toFirestore: (teacher, _) => teacher.toJson());
}
