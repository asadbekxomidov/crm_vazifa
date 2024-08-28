part of "auth_bloc.dart";

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadedState extends AuthState {}
class AuthLoadingState extends AuthState {}

class Authenticated extends AuthState {
  final String token;

  Authenticated({required this.token});

  @override
  List<Object> get props => [token];
}

class UnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}
