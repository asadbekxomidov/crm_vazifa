import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/data/models/models.dart';

class GroupInformationScreen extends StatefulWidget {
  final GroupModel groupModel;
  const GroupInformationScreen({super.key, required this.groupModel});

  @override
  State<GroupInformationScreen> createState() => _GroupInformationScreenState();
}

class _GroupInformationScreenState extends State<GroupInformationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22.h, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pushReplacement(
        //           context, MaterialPageRoute(builder: (ctx) => GroupScreen()));
        //     },
        //     icon: Icon(Icons.arrow_back_ios, size: 22.h, color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        title: Text(
          widget.groupModel.name,
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.h),
        children: [
          _buildTeacherInfo(widget.groupModel.main_teacher),
          SizedBox(height: 10.h),
          _buildTeacherInfo(widget.groupModel.assistant_teacher),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Students",
              style: TextStyle(fontSize: 22.h, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10.h),
          ...widget.groupModel.students.map((student) {
            return _buildStudentInfo(student);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTeacherInfo(UserModel teacher) {
    return ListTile(
      contentPadding: EdgeInsets.all(10.r),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      leading: _buildAvatar(teacher.photo),
      title: Text(
        teacher.name,
        style: TextStyle(
          fontSize: 16.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        teacher.email ?? 'usernotfound@gmail.com',
        style: TextStyle(
          fontSize: 13.h,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            teacher.phone ?? 'No phone number',
            style: TextStyle(fontSize: 14.h),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfo(UserModel student) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.r),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        leading: _buildAvatar(student.photo),
        title: Text(
          student.name,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          student.email ?? 'usernotfound@gmail.com',
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 12.h,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10.h),
            Text(
              student.phone ?? 'No phone number',
              style: TextStyle(
                fontSize: 13.h,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? photo) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(50.r),
      ),
      clipBehavior: Clip.hardEdge,
      child: photo == null
          ? Icon(
              CupertinoIcons.person_solid,
              size: 35.h,
              color: Colors.blue.shade700,
            )
          : Image.network(
              "http://millima.flutterwithakmaljon.uz/storage/avatars/$photo",
              height: 50.h,
              width: 50.w,
              fit: BoxFit.cover,
            ),
    );
  }
}
