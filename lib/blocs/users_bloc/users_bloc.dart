import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/data/services/services.dart';
part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitialState()) {
    on<GetUsersEvent>(_onGetUsers);
  }

  Future<void> _onGetUsers(GetUsersEvent event, emit) async {
    emit(UsersLoadingState());
    final UserService userService = UserService();
    try {
      final Map<String, dynamic> response = await userService.getUsers();
      List<UserModel> users = [];

      response['data'].forEach((value) {
        users.add(UserModel.fromMap(value));
      });

      emit(UsersLoadedState(users: users));
    } catch (e) {
      emit(UsersErrorState(error: e.toString()));
    }
  }
}
