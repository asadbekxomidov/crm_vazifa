import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/data/models/group_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/screens/admin/ui/admin_screen.dart';
import 'package:vazifa/ui/widget/add_student.dart';

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
        centerTitle: true,
        title: Text(
          "Add Student To Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "Students Id:  ",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          "${students.join(", ")}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
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
                    ))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<GroupBloc>().add(AddStudentsToGroupEvent(
                      groupId: widget.groupModel.id, studentsId: students));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: Text(
                  "Add Students",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
