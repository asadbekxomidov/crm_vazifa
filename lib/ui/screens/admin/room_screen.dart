import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/ui/screens/admin/manage_room.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/widget/room_item.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(GetRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 28.h,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.blue.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.meeting_room, color: Colors.white, size: 30.h),
            SizedBox(width: 10.w),
            Text(
              "Rooms",
              style: TextStyle(
                  fontSize: 25.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<RoomBloc>().add(GetRoomsEvent());
            },
          ),
        ],
      ),
      drawer: CustomDrawerForAdmin(),
      body: BlocBuilder<RoomBloc, RoomState>(builder: (context, state) {
        if (state is RoomLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade800),
            ),
          );
        }
        if (state is RoomErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60.h, color: Colors.red),
                SizedBox(height: 20.h),
                Text(
                  state.error,
                  style: TextStyle(fontSize: 18.h, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        if (state is RoomLoadedState) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return RoomItem(roomModel: state.rooms[index]);
            },
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sentiment_dissatisfied,
                  size: 60.h, color: Colors.grey),
              SizedBox(height: 20.h),
              Text(
                "Roomlar topilmadi!",
                style: TextStyle(fontSize: 18.h, color: Colors.grey),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManageRoom(
                  roomModel: null,
                ),
              ));
        },
        child: Icon(Icons.add, size: 30.h, color: Colors.white),
      ),
    );
  }
}
