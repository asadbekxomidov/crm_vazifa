import 'package:equatable/equatable.dart';
import 'package:vazifa/data/models/user_model.dart';

sealed class CurrentUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentUserInitialState extends CurrentUserState {}

class CurrentUserLoadingState extends CurrentUserState {}

class CurrentUserLoadedState extends CurrentUserState {
  final UserModel user;

  CurrentUserLoadedState({required this.user});
}

class CurrentUserErrorState extends CurrentUserState {
  final String error;
  CurrentUserErrorState({required this.error});
}
