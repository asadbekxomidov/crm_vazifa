import 'package:flutter/material.dart';
import 'package:vazifa/data/models/group_model.dart';
import 'package:vazifa/ui/screens/group_information_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupItemForStudent extends StatelessWidget {
  final int role;
  final GroupModel groupModel;
  const GroupItemForStudent(
      {super.key, required this.groupModel, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupInformationScreen(
                  groupModel: groupModel,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade800, Colors.blue.shade900],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child:
                            Icon(Icons.group, size: 30.h, color: Colors.white),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Group: ${groupModel.name}",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: Colors.white.withOpacity(0.3), thickness: 1.h),
                  SizedBox(height: 16.h),
                  _buildTeacherInfo(
                    icon: Icons.person,
                    label: "Main Teacher",
                    id: groupModel.main_teacher.id.toString(),
                  ),
                  SizedBox(height: 8.h),
                  _buildTeacherInfo(
                    icon: Icons.person_2_outlined,
                    label: "Assistant Teacher",
                    id: groupModel.assistant_teacher.id.toString(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeacherInfo({
    required IconData icon,
    required String label,
    required String id,
  }) {
    return Row(
      children: [
        Icon(icon, size: 22.h, color: Colors.white70),
        SizedBox(width: 8.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16.sp, color: Colors.white70),
              children: [
                TextSpan(
                    text: "$label: ",
                    style: TextStyle(fontWeight: FontWeight.w300)),
                TextSpan(
                    text: id, style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
