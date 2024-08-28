import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_event.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_state.dart';
import 'package:vazifa/data/models/user_model.dart';
import 'package:vazifa/data/services/user_service.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc() : super(CurrentUserInitialState()) {
    on<GetCurrentUserEvent>(_onGetUser);
    on<UpdateCurrentUserEvent>(_updateUser);
  }

  Future<void> _onGetUser(GetCurrentUserEvent event, emit) async {
    emit(CurrentUserLoadingState());
    final UserService userService = UserService();
    try {
      final Map<String, dynamic> response = await userService.getUser();

      UserModel userModel = UserModel.fromMap(response['data']);
      emit(CurrentUserLoadedState(user: userModel));
    } catch (e) {
      emit(CurrentUserErrorState(error: e.toString()));
    }
  }

  Future<void> _updateUser(UpdateCurrentUserEvent event, emit) async {
    emit(CurrentUserLoadingState());
    final UserService userService = UserService();
    try {
      await userService.updateProfile(
          name: event.name,
          email: event.email,
          phone: event.phone,
          photo: event.phote);
      add(GetCurrentUserEvent());
    } catch (e) {
      emit(CurrentUserErrorState(error: e.toString()));
    }
  }
}
