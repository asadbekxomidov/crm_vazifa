part of 'timetable_bloc.dart';


sealed class TimeTableState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimeTableInitialState extends TimeTableState {}

class TimeTableLoadingState extends TimeTableState {}

class TimeTableLoadedState extends TimeTableState {
  final Timetable TimeTables;

  TimeTableLoadedState({required this.TimeTables});
}


class TimeTableErrorState extends TimeTableState {
  final String error;
  TimeTableErrorState({required this.error});
}
