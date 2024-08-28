import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vazifa/data/models/social_login_model.dart';
import 'package:vazifa/data/services/authentification_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum SocialLoginTypes { google, facebook, github }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogIn>(_onLogIn);
    on<LoggedOut>(_onLoggedOut);
    on<Register>(_onRegister);
    on<SocialLogInEvent>(_onSocialLogin);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      emit(Authenticated(token: token));
    } else {
      emit(UnauthenticatedState());
    }
  }

  void _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final prefs = await SharedPreferences.getInstance();
    try {
      final AuthentificationService authentificationService =
          AuthentificationService();

      final response = await authentificationService.register(
        event.name,
        event.phone,
        event.role,
        event.password,
        event.passwordConfirmation,
      );
      if (response['success'] == true) {
        await prefs.setString('token', response['data']['token']);
        emit(Authenticated(token: response['data']['token']));
      } else {
        emit(
          AuthErrorState(error: "telefon raqam band"),
        );
      }
    } on DioException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }

  void _onLogIn(LogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final AuthentificationService authentificationService =
          AuthentificationService();
      final response =
          await authentificationService.login(event.phone, event.password);
      if (response['success'].toString() == "true") {
        await prefs.setString('token', response['data']['token']);
        emit(Authenticated(token: response['data']['token']));
      } else {
        emit(
          AuthErrorState(error: "login yoki parol xato"),
        );
      }
    } catch (error) {
      emit(AuthErrorState(error: error.toString()));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final AuthentificationService authentificationService =
          AuthentificationService();
      final String response = await authentificationService.logout();
      if (response == 'success') {
        await prefs.remove('token');
        emit(UnauthenticatedState());
      } else {
        emit(AuthErrorState(error: response));
      }
    } catch (error) {
      emit(AuthErrorState(error: error.toString()));
    }
  }

  void _onSocialLogin(
    SocialLogInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final AuthentificationService authentificationService =
        AuthentificationService();
    emit(AuthLoadingState());

    try {
      SocialLoginRequest? request;
      switch (event.type) {
        case SocialLoginTypes.google:
          const List<String> scopes = <String>['email'];
          final googleSignIn = GoogleSignIn(scopes: scopes);
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            request = SocialLoginRequest(
              name: googleUser.displayName ?? '',
              email: googleUser.email,
            );
          }
          break;
        case SocialLoginTypes.facebook:
          final result = await FacebookAuth.instance.login();
          if (result.status == LoginStatus.success) {
            final userData = await FacebookAuth.i.getUserData(
              fields: "name,email",
            );
            request = SocialLoginRequest(
              name: userData['name'] ?? '',
              email: userData['email'],
            );
          }
          break;
        default:
          return;
      }

      if (request != null) {
        final data = await authentificationService.socialLogin(request);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data.token);
        emit(Authenticated(token: data.token));
      } else {
        throw ('User not found');
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
