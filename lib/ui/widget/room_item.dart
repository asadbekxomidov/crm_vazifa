import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_event.dart';
import 'package:vazifa/data/models/room_model.dart';
import 'package:vazifa/ui/screens/admin/manage_room.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomItem extends StatefulWidget {
  final RoomModel roomModel;
  const RoomItem({super.key, required this.roomModel});

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade900])),
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Room Name: ${widget.roomModel.name}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                "Descripstion: ${widget.roomModel.description}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Capacity: ${widget.roomModel.capacity}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManageRoom(
                                    roomModel: widget.roomModel,
                                  ),
                                ));
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 26.h,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            context.read<RoomBloc>().add(
                                DeleteRoomEvent(roomId: widget.roomModel.id));
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 26.h,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
