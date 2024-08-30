import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/screens/admin/add_group.dart';
import 'package:vazifa/ui/screens/admin/room_screen.dart';
import 'package:vazifa/ui/screens/group_screen.dart';
import 'package:vazifa/ui/screens/profile_screen.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';
import 'package:vazifa/ui/screens/admin/show_users_screen.dart';
import 'package:vazifa/ui/widget/subject/subject_screen.dart';

class CustomDrawerForAdmin extends StatelessWidget {
  const CustomDrawerForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.blue.shade900],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.admin_panel_settings,
                      size: 60.r, color: Colors.white),
                  SizedBox(height: 10.h),
                  Text(
                    "ADMIN MENU",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                children: [
                  _buildListTile(
                      context, "Bosh sahifa", Icons.home, () => AdminScreen()),
                  _buildListTile(
                      context, "Profile", Icons.person, () => ProfileScreen(role: 3)),
                  _buildListTile(context, "Students", Icons.school,
                      () => ShowUsersScreen(role: 1)),
                  _buildListTile(context, "Teachers", Icons.person_2,
                      () => ShowUsersScreen(role: 2)),
                  _buildListTile(context, "Admins", Icons.admin_panel_settings,
                      () => ShowUsersScreen(role: 3)),
                  _buildListTile(
                      context, "Groups", Icons.group, () => GroupScreen()),
                  _buildListTile(
                      context, "Add Group", Icons.group_add, () => AddGroup()),
                  _buildListTile(
                      context, "Rooms", Icons.meeting_room, () => RoomScreen()),
                  _buildListTile(context, "Subject screen", Icons.subject,
                      () => SubjectScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData icon,
      Function() navigateTo) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 24.r),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.h),
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) {
                return navigateTo();
              },
            ),
          );
        },
        // onTap: () {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (ctx) {
        //       return navigateTo();
        //     }),
        //   );
        // },
      ),
    );
  }
}
