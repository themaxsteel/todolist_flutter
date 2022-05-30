import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/pages/task_detail_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';
import 'package:todo_list_flutter/widgets/task_card.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskProvider provider = Provider.of<TaskProvider>(context, listen: true);
    List<TaskModel> task = provider.task;

    List<TaskModel> routine = task.where((task) {
      return task.category!.contains('Routines');
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Routines'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            await provider.getTask();
          },
          child: ListView.builder(
              itemCount: routine.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => TaskDetailPage(task: routine[index]),
                    );
                  },
                  child: TaskCard(
                      title: routine[index].name!,
                      category: routine[index].category!,
                      level: routine[index].level!,
                      clock: routine[index].date!),
                );
              }),
        ),
      ),
    );
  }
}
