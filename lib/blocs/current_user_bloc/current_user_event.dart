part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentUserEvent extends CurrentUserEvent {}

class UpdateCurrentUserEvent extends CurrentUserEvent {
  final String name;
  final String phone;
  final String? email;
  final File? phote;

  UpdateCurrentUserEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.phote,
  });
}
