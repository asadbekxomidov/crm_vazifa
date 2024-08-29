import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/data/models/group_model.dart';
import 'package:vazifa/ui/screens/admin/add_student_to_group.dart';
import 'package:vazifa/ui/screens/admin/create_timetable.dart';
import 'package:vazifa/ui/screens/admin/show_group_timetable.dart';
import 'package:vazifa/ui/screens/admin/update_group.dart';
import 'package:vazifa/ui/screens/group_information_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupItemForAdmin extends StatelessWidget {
  final GroupModel groupModel;

  const GroupItemForAdmin({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
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
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade800, Colors.blue.shade900],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade900.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.group, size: 28.h, color: Colors.white),
                    Expanded(
                      child: Text(
                        "Group: ${groupModel.name}",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddStudentToGroup(
                              groupModel: groupModel,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.person_add_solid,
                        size: 26.h,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.person, size: 27.h, color: Colors.white),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Teacher Id: ${groupModel.main_teacher.id}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateGroup(
                              group: groupModel,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 26.h,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.person_2_outlined,
                        size: 27.h, color: Colors.white),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Assistant: ${groupModel.assistant_teacher.id}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<GroupBloc>().add(
                              DeleteGroupEvent(groupId: groupModel.id),
                            );
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 26.h,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowGroupTimetable(
                                groupModel: groupModel,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Show Timetable",
                          style: TextStyle(
                              color: Colors.blue.shade800, fontSize: 14.h),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateTimetable(
                                groupId: groupModel.id,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Add Timetable",
                          style: TextStyle(
                              color: Colors.green.shade600, fontSize: 14.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
