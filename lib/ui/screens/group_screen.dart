import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_event.dart';
import 'package:vazifa/blocs/group_bloc/group_state.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/widget/group_item_for_admin.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController searchController = TextEditingController();
  Timer? debounce;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetGroupsEvent());
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      drawer: CustomDrawerForAdmin(),
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
          "Group",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, size: 24.sp),
                hintText: 'Search Groups',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GroupBloc, GroupState>(
              buildWhen: (previousState, currentState) {
                return currentState is GroupLoadedState ||
                    currentState is GroupLoadingState ||
                    currentState is GroupErrorState;
              },
              builder: (context, state) {
                if (state is GroupLoadingState) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: Colors.blue.shade800),
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
                      .where((group) =>
                          group.name.toLowerCase().contains(searchQuery))
                      .toList();

                  if (filteredGroups.isEmpty) {
                    return Center(
                      child: Text(
                        "bunday group mavjud emas",
                        style: TextStyle(
                            fontSize: 20.h,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: filteredGroups.length,
                    itemBuilder: (context, index) {
                      return GroupItemForAdmin(
                        groupModel: filteredGroups[index],
                      );
                    },
                  );
                }
                return Center(
                  child: Text("Grouplar mavjud emas!"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
