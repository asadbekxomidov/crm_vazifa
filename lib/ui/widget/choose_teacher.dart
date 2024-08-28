import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_event.dart';
import 'package:vazifa/blocs/users_bloc/users_state.dart';
import 'package:vazifa/data/models/user_model.dart';

Future<UserModel?> chooseTeacher(BuildContext context) {
  BlocProvider.of<UsersBloc>(context).add(GetUsersEvent());
  UserModel? selectedUser;

  return showDialog<UserModel>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("O'qituvchi tanlang"),
        content: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UsersErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is UsersLoadedState) {
              List<UserModel> roleUsers =
                  state.users.where((element) => element.role == 2).toList();

              return Container(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: roleUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        roleUsers[index].name,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(roleUsers[index].phone!),
                      leading: CircleAvatar(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: roleUsers[index].photo == null
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                )
                              : Image.network(
                                  "http://millima.flutterwithakmaljon.uz/storage/avatars/${roleUsers[index].photo}",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      onTap: () {
                        selectedUser = roleUsers[index];
                        Navigator.of(context).pop(selectedUser);
                      },
                    );
                  },
                ),
              );
            }
            return Center(
              child: Text("User topilmadi!"),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Bekor qilish'),
          ),
        ],
      );
    },
  );
}
