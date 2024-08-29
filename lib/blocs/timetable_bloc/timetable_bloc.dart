import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/data/services/services.dart';
part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  TimetableBloc() : super(TimeTableInitialState()) {
    on<GetTimeTablesEvent>(_onGetRooms);
    on<CreateTimeTableEvent>(_addRoom);
  }

  Future<void> _onGetRooms(GetTimeTablesEvent event, emit) async {
  emit(TimeTableLoadingState());
  final TimetableService timetableService = TimetableService();
  try {
    final Map<String, dynamic> response =
        await timetableService.getGroupTimeTables(event.group_id);

    Timetable timeTable = Timetable.fromMap(response['data']);
    emit(TimeTableLoadedState(TimeTables: timeTable));
  } catch (e) {
    emit(TimeTableErrorState(error: e.toString()));
  }
}


  Future<void> _addRoom(CreateTimeTableEvent event, emit) async {
    final TimetableService timetableService = TimetableService();
    try {
      await timetableService.createTimetable(event.group_id, event.room_id,
          event.day_id, event.start_time, event.end_time);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }
}
