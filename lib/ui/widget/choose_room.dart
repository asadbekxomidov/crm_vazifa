import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';

Future<void> ChooseRoom(
  BuildContext context,
  int groupId,
  int dayId,
  String startTime,
  String endTime,
) async {
  BlocProvider.of<RoomBloc>(context).add(GetAvailableRoomsEvent(
    day_id: dayId,
    start_time: startTime,
    end_time: endTime,
  ));

  RoomModel? selectedRoom;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Xonani tanlang"),
            content: BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                if (state is RoomLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RoomErrorState) {
                  return Center(
                    child: Text("Xato yuz berdi: ${state.error}"),
                  );
                } else if (state is RoomLoadedState) {
                  final rooms = state.rooms;
                  if (rooms.isEmpty) {
                    return const Center(
                      child: Text("Xonalar topilmadi!"),
                    );
                  }

                  return Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            rooms[index].name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(rooms[index].capacity.toString()),
                          trailing: selectedRoom == rooms[index]
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            setState(() {
                              selectedRoom = rooms[index];
                            });
                          },
                        );
                      },
                    ),
                  );
                }
                return const Center(
                  child: Text("Xonalar yuklanmadi!"),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Bekor qilish'),
              ),
              ElevatedButton(
                onPressed: selectedRoom != null
                    ? () {
                        context.read<TimetableBloc>().add(CreateTimeTableEvent(
                              group_id: groupId,
                              room_id: selectedRoom!.id,
                              day_id: dayId,
                              start_time: startTime,
                              end_time: endTime,
                            ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text("Qo'shish"),
              ),
            ],
          );
        },
      );
    },
  );
}
