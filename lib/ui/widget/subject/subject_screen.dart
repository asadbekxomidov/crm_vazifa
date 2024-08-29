import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/blocs.dart';
import 'package:vazifa/ui/screens/admin/ui/widget/custom_drawer_for_admin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectScreen extends StatefulWidget {
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubjectBloc>(context).add(LoadSubjects());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerForAdmin(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, color: Colors.white, size: 26.h),
            SizedBox(width: 10.w),
            Text(
              'Subjects',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () =>
                BlocProvider.of<SubjectBloc>(context).add(LoadSubjects()),
          ),
        ],
      ),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          if (state is SubjectLoading) {
            return Center(
                child: CircularProgressIndicator(color: Colors.blue.shade800));
          } else if (state is SubjectLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.subjects.length,
                    itemBuilder: (context, index) {
                      final subject = state.subjects[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade800,
                            child: Text(
                              subject.name.substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(subject.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('ID: ${subject.id}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditSubjectDialog(
                                    context, subject.id, subject.name),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _confirmDeleteSubject(context, subject.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      onPressed: () => _showAddSubjectDialog(context),
                      child: Text('Add Subject',
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is SubjectError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60.h, color: Colors.red),
                  SizedBox(height: 20.h),
                  Text(state.message,
                      style: TextStyle(fontSize: 18.sp, color: Colors.red)),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_outlined, size: 60.h, color: Colors.grey),
                  SizedBox(height: 20.h),
                  Text('No subjects available',
                      style: TextStyle(fontSize: 18.sp, color: Colors.grey)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showAddSubjectDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Subject',
              style: TextStyle(color: Colors.blue.shade800)),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter subject name',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade800)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800),
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isNotEmpty) {
                  BlocProvider.of<SubjectBloc>(context).add(AddSubject(name));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showEditSubjectDialog(
      BuildContext context, int subjectId, String initialName) {
    final TextEditingController _controller =
        TextEditingController(text: initialName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Subject',
              style: TextStyle(color: Colors.blue.shade800)),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter new subject name',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade800)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800),
              onPressed: () {
                final newName = _controller.text.trim();
                if (newName.isNotEmpty) {
                  BlocProvider.of<SubjectBloc>(context)
                      .add(UpdateSubject(subjectId, newName));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteSubject(BuildContext context, int subjectId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Subject', style: TextStyle(color: Colors.red)),
          content: Text('Are you sure you want to delete this subject?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                BlocProvider.of<SubjectBloc>(context)
                    .add(DeleteSubject(subjectId));
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
