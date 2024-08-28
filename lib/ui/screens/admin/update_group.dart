import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/data/models/group_model.dart';
import 'package:vazifa/data/models/user_model.dart';
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
        centerTitle: true,
        title: Text(
          "Edit Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Main Teacher: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${mainTeacher != null ? mainTeacher!.name : ""}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      mainTeacher = await chooseTeacher(context);
                      setState(() {});
                    },
                    icon: Icon(CupertinoIcons.person_add_solid))
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Asistant Teacher: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${asistantTeacher != null ? asistantTeacher!.name : ""}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      asistantTeacher = await chooseTeacher(context);
                      setState(() {});
                    },
                    icon: Icon(CupertinoIcons.person_add_solid))
              ],
            ),
            SizedBox(height: 15),
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
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: Text(
                  "Update Group",
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
