import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/firebase/firestore_handler.dart';
import 'package:to_do_app/style/app_colors.dart';
import 'package:to_do_app/ui/home/tabs/task_item.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now(),
            focusDate: selectedDate,
            lastDate: DateTime.now().add(
              const Duration(
                days: 365,
              ),
            ),
            showTimelineHeader: false,
            dayProps: EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              inactiveDayStyle: DayStyle(
                dayStrStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              activeDayStyle: DayStyle(
                dayStrStyle: const TextStyle(
                  color: AppColors.lightPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                dayNumStyle: const TextStyle(
                  color: AppColors.lightPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
              height: 80,
            ),
            onDateChange: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FireStoreHandler.getTasksListen(
                FirebaseAuth.instance.currentUser!.uid,
                selectedDate,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(
                        snapshot.error.toString(),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Try Again'),
                      ),
                    ],
                  );
                }
                var tasksList = snapshot.data ?? [];
                return ListView.separated(
                    itemBuilder: (context, index) =>
                        TaskItem(task: tasksList[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: tasksList.length);
              },
            ),
          ),
        ],
      ),
    );
  }
}
