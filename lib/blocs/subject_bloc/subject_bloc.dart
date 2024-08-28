import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/data/services/subject_services.dart';
import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
import 'package:vazifa/blocs/subject_bloc/subject_state.dart';
import 'package:vazifa/data/models/subject_model.dart';

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
