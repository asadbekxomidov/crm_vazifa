import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/ui/screens/admin/room_screen.dart';

class ManageRoom extends StatefulWidget {
  final RoomModel? roomModel;
  const ManageRoom({super.key, required this.roomModel});

  @override
  State<ManageRoom> createState() => _ManageRoomState();
}

class _ManageRoomState extends State<ManageRoom> {
  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController descriptionEditingController =
      TextEditingController();

  final TextEditingController capacityEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.roomModel != null) {
      nameEditingController.text = widget.roomModel!.name;
      descriptionEditingController.text = widget.roomModel!.description;
      capacityEditingController.text = widget.roomModel!.capacity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 26.h),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          widget.roomModel == null ? "Add Room" : "Edit Room",
          style: TextStyle(
              fontSize: 24.h, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade100, Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 15),
                TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blue.shade800, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: descriptionEditingController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blue.shade800, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: capacityEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Capacity",
                    labelStyle: TextStyle(color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blue.shade800, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                  ),
                ),
                SizedBox(height: 380.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<RoomBloc>().add(AddRoomEvent(
                        name: nameEditingController.text,
                        description: descriptionEditingController.text,
                        capacity: int.parse(capacityEditingController.text)));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Room",
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
