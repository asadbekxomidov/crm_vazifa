part of 'group_bloc.dart';

sealed class GroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGroupsEvent extends GroupEvent {}

class GetStudentGroupsEvent extends GroupEvent {}

class GetTeacherGroupsEvent extends GroupEvent {}

class UpdateGroupEvent extends GroupEvent {
  final int groupId;
  final String name;
  final int main_teacher_id;
  final int assistant_teacher_id;

  UpdateGroupEvent({
    required this.groupId,
    required this.name,
    required this.main_teacher_id,
    required this.assistant_teacher_id,
  });
}

class DeleteGroupEvent extends GroupEvent {
  final int groupId;

  DeleteGroupEvent({
    required this.groupId,
  });
}

class AddGroupEvent extends GroupEvent {
  final String name;
  final int main_teacher_id;
  final int assistant_teacher_id;
  final int? subject_id;

  AddGroupEvent({
    required this.name,
    required this.main_teacher_id,
    required this.assistant_teacher_id,
    this.subject_id,
  });
}

class AddStudentsToGroupEvent extends GroupEvent {
  final int groupId;
  final List studentsId;

  AddStudentsToGroupEvent({
    required this.groupId,
    required this.studentsId,
  });
}
