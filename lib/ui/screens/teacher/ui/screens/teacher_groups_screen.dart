import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/ui/screens/teacher/ui/widgets/teacher_drawer.dart';
import 'package:vazifa/ui/widget/group_item_for_student.dart';

class TeacherGroupsScreen extends StatefulWidget {
  const TeacherGroupsScreen({super.key});

  @override
  State<TeacherGroupsScreen> createState() => _TeacherGroupsScreenState();
}

class _TeacherGroupsScreenState extends State<TeacherGroupsScreen> {
  TextEditingController searchController = TextEditingController();
  Timer? debounce;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetTeacherGroupsEvent());
    searchController.addListener(() {
      onSearchChanged(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = query.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      drawer: TeacherDrawer(),
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
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        title: Text(
          'Teacher Groups',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade800),
            );
          }
          if (state is GroupErrorState) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(color: Colors.red, fontSize: 18.sp),
              ),
            );
          }
          if (state is GroupLoadedState) {
            final filteredGroups = state.groups
                .where(
                    (group) => group.name.toLowerCase().contains(searchQuery))
                .toList();

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,
                          size: 24.sp, color: Colors.blue.shade800),
                      hintText: 'Search Groups',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: Colors.blue.shade200, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: Colors.blue.shade800, width: 2),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredGroups.isEmpty
                      ? Center(
                          child: Text(
                            "Grouplar topilmadi!",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5.h),
                          itemCount: filteredGroups.length,
                          itemBuilder: (context, index) {
                            return GroupItemForStudent(
                                groupModel: filteredGroups[index], role: 2);
                          },
                        ),
                ),
              ],
            );
          }
          return Center(
            child: Text(
              "Grouplar mavjud emas!",
              style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700),
            ),
          );
        },
      ),
    );
  }
}
