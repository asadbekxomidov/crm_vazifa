part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRoomsEvent extends RoomEvent {}

class GetAvailableRoomsEvent extends RoomEvent {
  final int day_id;
  final String start_time;
  final String end_time;

  GetAvailableRoomsEvent({
    required this.day_id,
    required this.start_time,
    required this.end_time,
  });
}

class UpdateRoomEvent extends RoomEvent {
  final int roomId;
  final String name;
  final String description;
  final int capacity;

  UpdateRoomEvent({
    required this.roomId,
    required this.name,
    required this.description,
    required this.capacity,
  });
}

class DeleteRoomEvent extends RoomEvent {
  final int roomId;

  DeleteRoomEvent({
    required this.roomId,
  });
}

class AddRoomEvent extends RoomEvent {
  final String name;
  final String description;
  final int capacity;

  AddRoomEvent({
    required this.name,
    required this.description,
    required this.capacity,
  });
}
