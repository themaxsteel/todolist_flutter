import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/pages/edit_task_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';

class TaskDetailPage extends StatelessWidget {
  final TaskModel task;
  const TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            taskName(),
            const SizedBox(height: 20),
            taskCategoryAndLevel(),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Day',
                  style: subtitleTextStyle.copyWith(
                      fontWeight: regular, fontSize: 12),
                ),
                Text(
                  task.date!,
                  style:
                      blackTextStyle.copyWith(fontWeight: medium, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            taskAction()
          ],
        ),
      ),
    );
  }

  Widget taskAction() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(() => EditTaskPage(task: task));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Edit Task',
                textAlign: TextAlign.center,
                style:
                    whiteTextStyle.copyWith(fontWeight: medium, fontSize: 18),
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Consumer<TaskProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () async {
                        bool response =
                            await provider.deleteTask(int.parse(task.id!));
                        if (response) {
                          Get.back();
                        } else {
                          Get.snackbar('Error', 'Something went wrong');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Delete Task',
                          textAlign: TextAlign.center,
                          style: whiteTextStyle.copyWith(
                              fontWeight: medium, fontSize: 18),
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  Row taskCategoryAndLevel() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Category',
              style:
                  subtitleTextStyle.copyWith(fontWeight: regular, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              task.category!,
              style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 18),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Task Level',
              style:
                  subtitleTextStyle.copyWith(fontWeight: regular, fontSize: 12),
            ),
            const SizedBox(height: 5),
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: task.level == 'Easy'
                    ? easyColor
                    : task.level == 'Medium'
                        ? mediumColor
                        : hardColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                task.level!,
                textAlign: TextAlign.center,
                style:
                    whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column taskName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Name',
          style: subtitleTextStyle.copyWith(fontWeight: regular, fontSize: 12),
        ),
        Text(
          task.name!,
          style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 18),
        ),
      ],
    );
  }
}
