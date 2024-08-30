import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/ui/screens/student/ui/widgets/student_drawer.dart';
import 'package:vazifa/ui/widget/group_item_for_student.dart';

class UserScreen extends StatefulWidget {
  final int role;

  const UserScreen({super.key, required this.role});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetStudentGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StudentDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
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
        title: Text(
          widget.role == 1
              ? "Students"
              : widget.role == 2
                  ? "Teachers"
                  : "Admins",
          style: TextStyle(
            fontSize: 24.h,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 24.h, color: Colors.white),
            onPressed: () async {
              context.read<AuthBloc>().add(LoggedOut());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
        if (state is GroupLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GroupErrorState) {
          return Center(
            child: Text(
              'Malumotlar yuklanmoqda',
              style: TextStyle(
                fontSize: 18.h,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            // child: Text(
            //   state.error,
            //   style: TextStyle(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.w500,
            //     color: Colors.red,
            //   ),
            // ),
          );
        }
        if (state is GroupLoadedState) {
          if (state.groups.isEmpty) {
            return Center(
              child: Text(
                "Grouplar qoshilmagan!",
                style: TextStyle(
                  fontSize: 18.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: state.groups.length,
            itemBuilder: (context, index) {
              return GroupItemForStudent(
                groupModel: state.groups[index],
                role: widget.role,
              );
            },
          );
        }
        return Center(
          child: Text(
            "Grouplar topilmadi!",
            style: TextStyle(
              fontSize: 18.h,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }),
    );
  }
}
