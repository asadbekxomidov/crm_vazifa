// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
// import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
// import 'package:vazifa/data/models/subject_model.dart';
// import 'package:vazifa/data/services/subject_services.dart';
// import 'package:vazifa/ui/widget/subject/subject_dilaog.dart';

// class SubjectSelector extends StatelessWidget {
//   final Function(SubjectModel?) onSubjectSelected;

//   SubjectSelector({required this.onSubjectSelected});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SubjectBloc(SubjectServices())..add(LoadSubjects()),
//       child: AlertDialog(
//         title: Text('Select Subject'),
//         content: SubjectDialog(
//           onSubjectSelected: (subject) {
//             onSubjectSelected(subject);
//             Navigator.of(context).pop(subject);
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   static Future<SubjectModel?> show(BuildContext context) async {
//     SubjectModel? selectedSubject;

//     await showDialog<SubjectModel>(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return SubjectSelector(
//           onSubjectSelected: (subject) {
//             selectedSubject = subject;
//           },
//         );
//       },
//     );

//     return selectedSubject;
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_event.dart';
import 'package:vazifa/blocs/subject_bloc/subject_state.dart';
import 'package:vazifa/data/models/subject_model.dart';

Future<SubjectModel?> chooseSubject(BuildContext context) {
  BlocProvider.of<SubjectBloc>(context).add(LoadSubjects());
  SubjectModel? selectedSubjects;

  return showDialog<SubjectModel>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Fanni tanlang"),
        content: BlocBuilder<SubjectBloc, SubjectState>(
          builder: (context, state) {
            if (state is SubjectLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SubjectError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is SubjectLoaded) {
              List<SubjectModel> subjects = state.subjects;

              return Container(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "Name: ${subjects[index].name}",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text("Id: ${subjects[index].id}"),
                      onTap: () {
                        selectedSubjects = subjects[index];
                        Navigator.of(context).pop(selectedSubjects);
                      },
                    );
                  },
                ),
              );
            }
            return Center(
              child: Text("User topilmadi!"),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Bekor qilish'),
          ),
        ],
      );
    },
  );
}
