import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/data/models/user_model.dart';
import 'package:vazifa/data/models/subject_model.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';
import 'package:vazifa/ui/widget/choose_teacher.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/widget/subject/choose_subject.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  TextEditingController nameEditingController = TextEditingController();
  UserModel? main_teacher;
  UserModel? assistant_teacher;
  SubjectModel? subject;

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
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          "Add Group",
          style: TextStyle(
              fontSize: 26.h, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      drawer: CustomDrawerForAdmin(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(
                "Group Information",
                style: TextStyle(
                    fontSize: 24.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: nameEditingController,
                decoration: InputDecoration(
                  labelText: "Group name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide:
                        BorderSide(color: Colors.blue.shade800, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              _buildInfoRow("Teacher", main_teacher?.name, () async {
                final selectedTeacher = await chooseTeacher(context);
                if (selectedTeacher != null) {
                  setState(() {
                    main_teacher = selectedTeacher;
                  });
                }
              }),
              SizedBox(height: 15.h),
              _buildInfoRow("Assistant teacher", assistant_teacher?.name,
                  () async {
                final selectedTeacher = await chooseTeacher(context);
                if (selectedTeacher != null) {
                  setState(() {
                    assistant_teacher = selectedTeacher;
                  });
                }
              }),
              SizedBox(height: 15.h),
              _buildInfoRow("Subject", subject?.name, () async {
                final selectedSubject = await chooseSubject(context);
                if (selectedSubject != null) {
                  setState(() {
                    subject = selectedSubject;
                  });
                }
              }, icon: CupertinoIcons.book_fill),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (main_teacher == null ||
                        assistant_teacher == null ||
                        subject == null ||
                        nameEditingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Please fill in all the required fields.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    context.read<GroupBloc>().add(
                          AddGroupEvent(
                            name: nameEditingController.text,
                            main_teacher_id: main_teacher!.id,
                            assistant_teacher_id: assistant_teacher!.id,
                            subject_id: subject!.id,
                          ),
                        );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    "Create Group",
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String? value, VoidCallback onPressed,
      {IconData icon = CupertinoIcons.add_circled_solid}) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.h,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  value ?? "Not selected",
                  style: TextStyle(
                    fontSize: 20.h,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.blue.shade800),
          ),
        ],
      ),
    );
  }
}
