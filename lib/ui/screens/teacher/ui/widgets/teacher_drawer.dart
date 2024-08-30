import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/screens/profile_screen.dart';
import 'package:vazifa/ui/screens/teacher/ui/screens/teacher_groups_screen.dart';
import 'package:vazifa/ui/screens/teacher/ui/screens/teacher_screeen.dart';

class TeacherDrawer extends StatelessWidget {
  const TeacherDrawer({super.key});

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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    CupertinoIcons.person_circle_fill,
                    size: 70.r,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Teacher",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildListTile(
              context,
              icon: CupertinoIcons.house_fill,
              title: "Home",
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (ctx) => TeacherScreeen()),
              ),
            ),
            _buildListTile(
              context,
              icon: CupertinoIcons.person_crop_circle,
              title: "Profile",
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (ctx) => ProfileScreen(
                          role: 2,
                        )),
              ),
            ),
            _buildListTile(
              context,
              icon: CupertinoIcons.group_solid,
              title: "Groups Teacher",
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (ctx) => TeacherGroupsScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        leading: Icon(icon, size: 24.r, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14.h,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
