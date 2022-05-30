import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/pages/task_detail_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';
import 'package:todo_list_flutter/widgets/task_card.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskProvider provider = Provider.of<TaskProvider>(context, listen: false);
    List<TaskModel> task = provider.task;

    List<TaskModel> work = task.where((task) {
      return task.category!.contains('Works');
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Works'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            await provider.getTask();
          },
          child: ListView.builder(
              itemCount: work.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => TaskDetailPage(task: work[index]));
                  },
                  child: TaskCard(
                      title: work[index].name!,
                      category: work[index].category!,
                      level: work[index].level!,
                      clock: work[index].date!),
                );
              }),
        ),
      ),
    );
  }
}
