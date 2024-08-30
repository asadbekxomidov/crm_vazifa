import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';
import 'package:vazifa/ui/screens/teacher/ui/screens/teacher_screeen.dart';
import 'package:vazifa/ui/screens/student/ui/screens/user_screen.dart';

class ManagmentScreen extends StatefulWidget {
  const ManagmentScreen({super.key});

  @override
  State<ManagmentScreen> createState() => _ManagmentScreenState();
}

class _ManagmentScreenState extends State<ManagmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentUserBloc>().add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
          builder: (context, state) {
        if (state is CurrentUserLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CurrentUserErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is CurrentUserLoadedState) {
          if (state.user.role == 1) {
            return UserScreen(role: 1);
          } else if (state.user.role == 2) {
            return TeacherScreeen();
          } else if (state.user.role == 3) {
            return AdminScreen();
          }
        }
        return Center(
          child: Text(
            "Malumotlar yuklanmoqda!",
            style: TextStyle(fontSize: 20.h, color: Colors.blue.shade800),
          ),
          // child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
