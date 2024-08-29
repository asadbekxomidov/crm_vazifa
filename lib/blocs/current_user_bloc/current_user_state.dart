part of 'current_user_bloc.dart';

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
