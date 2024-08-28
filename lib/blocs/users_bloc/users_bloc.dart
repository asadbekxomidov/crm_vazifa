import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_event.dart';
import 'package:vazifa/blocs/users_bloc/users_state.dart';
import 'package:vazifa/data/models/user_model.dart';
import 'package:vazifa/data/services/user_service.dart';

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
