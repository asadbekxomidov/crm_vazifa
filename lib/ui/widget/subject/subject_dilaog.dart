import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_state.dart';
import 'package:vazifa/data/models/subject_model.dart';

class SubjectDialog extends StatelessWidget {
  final Function(SubjectModel) onSubjectSelected;

  const SubjectDialog({required this.onSubjectSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Subject'),
      content: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          if (state is SubjectLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SubjectLoaded) {
            return Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.subjects.length,
                itemBuilder: (context, index) {
                  final subject = state.subjects[index];
                  return ListTile(
                    title: Text(subject.name),
                    onTap: () {
                      onSubjectSelected(subject);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            );
          } else if (state is SubjectError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No subjects available'));
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
