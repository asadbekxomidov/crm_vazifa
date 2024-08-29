import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';
import 'package:vazifa/ui/widget/add_student.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddStudentToGroup extends StatefulWidget {
  final GroupModel groupModel;
  const AddStudentToGroup({super.key, required this.groupModel});

  @override
  State<AddStudentToGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddStudentToGroup> {
  TextEditingController studentsIdController = TextEditingController();
  List students = [];

  @override
  void initState() {
    super.initState();

    widget.groupModel.students.forEach(
      (element) {
        students.add(element.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 28.h),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          "Add Student To Group",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 80.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Students Id:",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade800),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "${students.join(", ")}",
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          List? box = await updateStudents(context, students);
                          if (box != null) {
                            students = box;
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          CupertinoIcons.person_add_solid,
                          size: 30.h,
                          color: Colors.blue.shade800,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<GroupBloc>().add(AddStudentsToGroupEvent(
                      groupId: widget.groupModel.id, studentsId: students));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Add Students",
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
    );
  }
}
