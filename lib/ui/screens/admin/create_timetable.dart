import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa/ui/widget/choose_room.dart';

class CreateTimetable extends StatefulWidget {
  final int groupId;
  const CreateTimetable({super.key, required this.groupId});

  @override
  _CreateTimetableState createState() => _CreateTimetableState();
}

class _CreateTimetableState extends State<CreateTimetable> {
  int? selectedDayIndex;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final List<String> weekDays = [
    'Dushanba',
    'Seshanba',
    'Chorshanba',
    'Payshanba',
    'Juma',
    'Shanba',
    'Yakshanba',
  ];

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String formattedTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 24.h, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
        title: Text(
          "Create Timetable",
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
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<int>(
              hint: Text(
                "Hafta kunini tanlang",
                style: TextStyle(fontSize: 18.sp),
              ),
              value: selectedDayIndex,
              isExpanded: true,
              onChanged: (int? newValue) {
                setState(() {
                  selectedDayIndex = newValue;
                });
              },
              items: weekDays.asMap().entries.map((entry) {
                int idx = entry.key;
                String day = entry.value;
                return DropdownMenuItem<int>(
                  value: idx,
                  child: Text(day, style: TextStyle(fontSize: 18.sp)),
                );
              }).toList(),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Boshlanish vaqti:", style: TextStyle(fontSize: 18.sp)),
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  child: Text(
                    startTime == null ? "Tanlash" : formattedTime(startTime!),
                    style: TextStyle(fontSize: 18.h),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tugash vaqti:", style: TextStyle(fontSize: 18.sp)),
                ElevatedButton(
                  onPressed: () => _selectTime(context, false),
                  child: Text(
                    endTime == null ? "Tanlash" : formattedTime(endTime!),
                    style: TextStyle(fontSize: 18.h),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedDayIndex != null &&
                        startTime != null &&
                        endTime != null
                    ? () async {
                        await ChooseRoom(
                          context,
                          widget.groupId,
                          selectedDayIndex! + 1,
                          formattedTime(startTime!),
                          formattedTime(endTime!),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  backgroundColor: Colors.blue.shade800,
                  textStyle: TextStyle(fontSize: 20.sp),
                ),
                child: Text(
                  "Get Rooms",
                  style: TextStyle(color: Colors.white, fontSize: 16.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
