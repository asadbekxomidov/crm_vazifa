import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';
import 'package:vazifa/ui/widget/choose_teacher.dart';

class UpdateGroup extends StatefulWidget {
  final GroupModel group;
  const UpdateGroup({super.key, required this.group});

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  TextEditingController nameEditingController = TextEditingController();
  UserModel? mainTeacher;
  UserModel? asistantTeacher;

  @override
  void initState() {
    super.initState();
    nameEditingController.text = widget.group.name;
    mainTeacher = widget.group.main_teacher;
    asistantTeacher = widget.group.assistant_teacher;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 26.h),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          "Edit Group",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade100, Colors.white],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.blue.shade800, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
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
                                "Main Teacher:",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade800),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${mainTeacher != null ? mainTeacher!.name : ""}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            mainTeacher = await chooseTeacher(context);
                            setState(() {});
                          },
                          icon: Icon(CupertinoIcons.person_add_solid,
                              color: Colors.blue.shade800),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
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
                                "Assistant Teacher:",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade800),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${asistantTeacher != null ? asistantTeacher!.name : ""}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            asistantTeacher = await chooseTeacher(context);
                            setState(() {});
                          },
                          icon: Icon(CupertinoIcons.person_add_solid,
                              color: Colors.blue.shade800),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 300.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<GroupBloc>().add(UpdateGroupEvent(
                          groupId: widget.group.id,
                          name: nameEditingController.text,
                          main_teacher_id: mainTeacher!.id,
                          assistant_teacher_id: asistantTeacher!.id,
                        ));
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
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Update Group",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
