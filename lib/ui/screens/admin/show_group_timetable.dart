import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_event.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_state.dart';
import 'package:vazifa/data/models/group_model.dart';
import 'package:vazifa/data/models/week_days.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowGroupTimetable extends StatefulWidget {
  final GroupModel groupModel;
  const ShowGroupTimetable({super.key, required this.groupModel});

  @override
  State<ShowGroupTimetable> createState() => _ShowGroupTimetableState();
}

class _ShowGroupTimetableState extends State<ShowGroupTimetable> {
  @override
  void initState() {
    super.initState();
    context
        .read<TimetableBloc>()
        .add(GetTimeTablesEvent(group_id: widget.groupModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "${widget.groupModel.name} Timetable",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context
                  .read<TimetableBloc>()
                  .add(GetTimeTablesEvent(group_id: widget.groupModel.id));
            },
          ),
        ],
      ),
      body: BlocBuilder<TimetableBloc, TimeTableState>(
        builder: (context, state) {
          if (state is TimeTableLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade800),
            );
          }
          if (state is TimeTableErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
                  SizedBox(height: 20.h),
                  Text('Malumotlay typeda hatolik bor!',
                      style: TextStyle(fontSize: 16.h, color: Colors.red)),
                  // Text(state.error,
                  //     style: TextStyle(fontSize: 18.sp, color: Colors.red)),
                ],
              ),
            );
          }
          if (state is TimeTableLoadedState) {
            return ListView(
              padding: EdgeInsets.all(16.r),
              children: state.TimeTables.week_days.entries.map((entry) {
                String weekDay = entry.key;
                List<WeekDays> timetable = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        weekDay,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ...timetable.map((day) {
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: ListTile(
                          leading: Icon(Icons.access_time,
                              color: Colors.blue.shade800),
                          title: Text(day.room,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp)),
                          subtitle: Text(
                            "${day.start_time} - ${day.end_time}",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16.sp),
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 20.h),
                  ],
                );
              }).toList(),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_busy, size: 60.sp, color: Colors.grey),
                SizedBox(height: 20.h),
                Text(
                  "Timetable mavjud emas!",
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
