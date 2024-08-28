import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      drawer: CustomDrawerForAdmin(),
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
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
        title: Text(
          "Admin Dashboard",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return Center(child: Text(''));
          }
          if (state is GroupErrorState) {
            return Center(
              child: Text(
                state.error.toString(),
                style: TextStyle(color: Colors.red, fontSize: 18.sp),
              ),
            );
          }
          // if (state is GroupLoadedState) {
          //   return _buildGroupList(state);
          // }
          return Text('');
        },
      ),
    );
  }

  // Widget _buildDashboard() {
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.all(20.r),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Welcome, Admin!",
  //           style: TextStyle(
  //             fontSize: 28.sp,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.blue.shade800,
  //           ),
  //         ),
  //         SizedBox(height: 20.h),
  //         _buildDashboardCard(
  //           "Total Groups",
  //           "15", // You can replace this with actual data
  //           Icons.group,
  //         ),
  //         SizedBox(height: 15.h),
  //         _buildDashboardCard(
  //           "Total Students",
  //           "150", // You can replace this with actual data
  //           Icons.school,
  //         ),
  //         SizedBox(height: 15.h),
  //         _buildDashboardCard(
  //           "Total Teachers",
  //           "20", // You can replace this with actual data
  //           Icons.person,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildDashboardCard(String title, String count, IconData icon) {
  //   return Container(
  //     padding: EdgeInsets.all(20.r),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.blue.shade100.withOpacity(0.5),
  //           blurRadius: 10,
  //           offset: Offset(0, 5),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(12.r),
  //           decoration: BoxDecoration(
  //             color: Colors.blue.shade100,
  //             shape: BoxShape.circle,
  //           ),
  //           child: Icon(icon, size: 30.r, color: Colors.blue.shade800),
  //         ),
  //         SizedBox(width: 20.w),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 18.sp,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.blue.shade800,
  //               ),
  //             ),
  //             Text(
  //               count,
  //               style: TextStyle(
  //                 fontSize: 24.sp,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.blue.shade900,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildGroupList(GroupLoadedState state) {
  //   return ListView.builder(
  //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  //     itemCount: state.groups.length,
  //     itemBuilder: (context, index) {
  //       return GroupItemForAdmin(groupModel: state.groups[index]);
  //     },
  //   );
  // }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () {
                context.read<AuthBloc>().add(LoggedOut());
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }
}
