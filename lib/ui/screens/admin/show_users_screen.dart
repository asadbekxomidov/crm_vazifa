import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/data/models/models.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/screens/details_screen.dart';

class ShowUsersScreen extends StatefulWidget {
  final int role;
  const ShowUsersScreen({super.key, required this.role});

  @override
  State<ShowUsersScreen> createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
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
          widget.role == 1
              ? "Students"
              : widget.role == 2
                  ? "Teachers"
                  : "Admins",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
        ),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade800),
            );
          }
          if (state is UsersErrorState) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(color: Colors.red, fontSize: 18.sp),
              ),
            );
          }
          if (state is UsersLoadedState) {
            List<UserModel> roleUsers = [];
            state.users.forEach((element) {
              if (element.role == widget.role) {
                roleUsers.add(element);
              }
            });

            if (roleUsers.isEmpty) {
              return Center(
                child: Text(
                  "User topilmadi!",
                  style:
                      TextStyle(fontSize: 18.sp, color: Colors.blue.shade800),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(10.r),
              itemCount: roleUsers.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              UsersDetailScreen(userModel: roleUsers[index]),
                        ),
                      );
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    title: Text(
                      roleUsers[index].name,
                      // roleUsers[index].name ?? 'No name available',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    subtitle: Text(
                      roleUsers[index].phone ?? 'No phone available',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.blue.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: roleUsers[index].photo == null
                            ? Icon(
                                Icons.person,
                                size: 30.r,
                                color: Colors.blue.shade800,
                              )
                            : Image.network(
                                "http://millima.flutterwithakmaljon.uz/storage/avatars/${roleUsers[index].photo}",
                                fit: BoxFit.cover,
                                width: 50.r,
                                height: 50.r,
                              ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue.shade800,
                      size: 18.r,
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text(
              "User topilmadi!",
              style: TextStyle(fontSize: 18.sp, color: Colors.blue.shade800),
            ),
          );
        },
      ),
    );
  }
}
