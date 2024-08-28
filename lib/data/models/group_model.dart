import 'package:vazifa/data/models/user_model.dart';
import 'package:vazifa/data/models/subject_model.dart';

class GroupModel {
  int id;
  String name;
  UserModel main_teacher;
  UserModel assistant_teacher;
  SubjectModel? subject;
  List<UserModel> students;

  GroupModel({
    required this.id,
    required this.name,
    required this.main_teacher,
    required this.assistant_teacher,
    this.subject,
    required this.students,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] as int,
      name: map['name'] as String,
      main_teacher: map['main_teacher'] != null
          ? UserModel.fromMap(map['main_teacher'] as Map<String, dynamic>)
          : UserModel.empty(),
      assistant_teacher: map['assistant_teacher'] != null
          ? UserModel.fromMap(map['assistant_teacher'] as Map<String, dynamic>)
          : UserModel.empty(),
      subject: map['subject'] != null
          ? SubjectModel.fromJson(map['subject'] as Map<String, dynamic>)
          : null,
      students: (map['students'] as List<dynamic>?)?.map((student) {
            return UserModel.fromMap(student as Map<String, dynamic>);
          }).toList() ??
          [],
    );
  }
}
