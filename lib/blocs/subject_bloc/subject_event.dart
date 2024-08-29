part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSubjects extends SubjectEvent {}

class AddSubject extends SubjectEvent {
  final String name;

  AddSubject(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateSubject extends SubjectEvent {
  final int subjectId;
  final String name;

  UpdateSubject(this.subjectId, this.name);

  @override
  List<Object> get props => [subjectId, name];
}

class DeleteSubject extends SubjectEvent {
  final int subjectId;

  DeleteSubject(this.subjectId);

  @override
  List<Object> get props => [subjectId];
}
