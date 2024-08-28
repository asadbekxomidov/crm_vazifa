import 'package:equatable/equatable.dart';
import 'package:vazifa/data/models/user_model.dart';

sealed class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<UserModel> users;

  UsersLoadedState({required this.users});
}

class UsersErrorState extends UsersState {
  final String error;
  UsersErrorState({required this.error});
}
