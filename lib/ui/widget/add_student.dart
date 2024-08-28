import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_event.dart';
import 'package:vazifa/blocs/users_bloc/users_state.dart';
import 'package:vazifa/data/models/user_model.dart';

Future<List?> updateStudents(BuildContext context, List selectedUserIds) {
  context.read<UsersBloc>().add(GetUsersEvent());
  return showDialog<List>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Studentlarni tanlang"),
            content:
                BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
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
                    state.users.where((user) => user.role == 1).toList();

                return SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: roleUsers.length,
                    itemBuilder: (context, index) {
                      UserModel user = roleUsers[index];
                      bool isSelected = selectedUserIds.contains(user.id);

                      return ListTile(
                        title: Text(
                          user.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(user.phone ??
                            'Telefon raqami mavjud emas'), // Provide a fallback value
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: user.photo == null
                              ? Icon(Icons.person, size: 40)
                              : Image.network(
                                  "http://millima.flutterwithakmaljon.uz/storage/avatars/${user.photo}",
                                  fit: BoxFit.cover,
                                ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedUserIds.remove(user.id);
                            } else {
                              selectedUserIds.add(user.id);
                            }
                          });
                        },
                      );
                    },
                  ),
                );
              }
              return Center(
                child: Text("User topilmadi!"),
              );
            }),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedUserIds);
                },
                child: Text('Qo\'shish'),
              ),
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
    },
  );
}
