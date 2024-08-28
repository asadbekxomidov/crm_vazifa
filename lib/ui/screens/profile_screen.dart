import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_event.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:vazifa/ui/screens/student/ui/widgets/student_drawer.dart';
import 'package:vazifa/ui/screens/teacher/ui/widgets/teacher_drawer.dart';

class ProfileScreen extends StatefulWidget {
  final int role;

  const ProfileScreen({super.key, required this.role});

  @override
  State<ProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  File? imageFile;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 300,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
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
          "Profile Screen",
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
      drawer: _buildDrawer(),
      body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoadingState) {
            return Center(
                child: CircularProgressIndicator(color: Colors.blue.shade800));
          } else if (state is CurrentUserLoadedState) {
            nameEditingController.text = state.user.name;
            phoneEditingController.text = state.user.phone!;
            emailEditingController.text = state.user.email ?? "";
            return SingleChildScrollView(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  _buildProfileImage(state),
                  SizedBox(height: 25.h),
                  _buildTextField(nameEditingController, "Name"),
                  SizedBox(height: 15.h),
                  _buildTextField(phoneEditingController, "Phone"),
                  SizedBox(height: 15.h),
                  _buildTextField(emailEditingController, "Email"),
                  SizedBox(height: 25.h),
                  _buildUpdateButton(),
                ],
              ),
            );
          } else if (state is CurrentUserErrorState) {
            return Center(
              child: Text(state.error,
                  style: TextStyle(color: Colors.red, fontSize: 18.sp)),
            );
          } else {
            return Center(
              child: Text("User topilmadi!", style: TextStyle(fontSize: 18.sp)),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileImage(CurrentUserLoadedState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200.r,
          height: 200.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: state.user.photo == null
              ? imageFile == null
                  ? Image.asset("assets/profile_logo.png", fit: BoxFit.cover)
                  : Image.file(imageFile!, fit: BoxFit.cover)
              : imageFile != null
                  ? Image.file(imageFile!, fit: BoxFit.cover)
                  : Image.network(
                      "http://millima.flutterwithakmaljon.uz/storage/avatars/${state.user.photo}",
                      fit: BoxFit.cover,
                    ),
        ),
        Positioned(
          right: 0,
          bottom: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: openGallery,
              icon: Icon(Icons.edit, color: Colors.white, size: 24.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue.shade800),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<CurrentUserBloc>().add(UpdateCurrentUserEvent(
                name: nameEditingController.text,
                phone: phoneEditingController.text,
                email: emailEditingController.text,
                phote: imageFile,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade800,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Text(
          "Update",
          style: TextStyle(
              fontSize: 16.h, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    switch (widget.role) {
      case 1:
        return StudentDrawer(); // Replace with the actual drawer widget for students
      case 2:
        return TeacherDrawer(); // Replace with the actual drawer widget for teachers
      case 3:
        return CustomDrawerForAdmin(); // Replace with the actual drawer widget for admins
      default:
        return Drawer(
          child: Center(
            child: Text("No Drawer for this role"),
          ),
        );
    }
  }
}
