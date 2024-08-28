part of "auth_bloc.dart";

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LogIn extends AuthEvent {
  final String phone;
  final String password;

  LogIn({required this.phone, required this.password});
}

class Register extends AuthEvent {
  final String name;
  final String phone;
  final int role;
  final String password;
  final String passwordConfirmation;

  Register({
    required this.name,
    required this.phone,
    required this.role,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [name, phone, password];
}

class LoggedOut extends AuthEvent {}

class SocialLogInEvent extends AuthEvent {
  final SocialLoginTypes type;

  SocialLogInEvent({required this.type});
}
