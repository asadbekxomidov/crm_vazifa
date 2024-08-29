import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/data/services/services.dart';
part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectServices _subjectServices;

  SubjectBloc(this._subjectServices) : super(SubjectInitial()) {
    on<LoadSubjects>((event, emit) async {
      emit(SubjectLoading());
      try {
        final response = await _subjectServices.getAllSubject();
        final subjects = (response['data'] as List)
            .map((item) => SubjectModel.fromJson(item))
            .toList();
        emit(SubjectLoaded(subjects));
      } catch (e) {
        emit(SubjectError('Failed to load subjects'));
      }
    });

    on<AddSubject>((event, emit) async {
      emit(SubjectLoading());
      try {
        await _subjectServices.addSubject(event.name);
        add(LoadSubjects());
      } catch (e) {
        emit(SubjectError('Failed to add subject'));
      }
    });

    on<UpdateSubject>((event, emit) async {
      emit(SubjectLoading());
      try {
        await _subjectServices.editSubject(event.subjectId, event.name);
        add(LoadSubjects());
      } catch (e) {
        emit(SubjectError('Failed to update subject'));
      }
    });

    on<DeleteSubject>((event, emit) async {
      emit(SubjectLoading());
      try {
        await _subjectServices.deleteSubject(event.subjectId);
        add(LoadSubjects()); // Refresh the list
      } catch (e) {
        emit(SubjectError('Failed to delete subject'));
      }
    });
  }
}
