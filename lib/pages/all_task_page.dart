import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/pages/task_detail_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';
import 'package:todo_list_flutter/widgets/task_card.dart';

class AllTaskPage extends StatefulWidget {
  AllTaskPage({Key? key, required this.isSearch}) : super(key: key);
  final bool isSearch;

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  TextEditingController search = TextEditingController();
  List<TaskModel> searched = [];

  @override
  Widget build(BuildContext context) {
    TaskProvider provider = Provider.of<TaskProvider>(context, listen: true);
    List<TaskModel> task = provider.task;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Task'),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            searchField(task, widget.isSearch),
            taskList(task, provider),
          ],
        ),
      ),
    );
  }

  Widget taskList(List<TaskModel> task, TaskProvider provider) {
    return Expanded(
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await provider.getTask();
        },
        child: ListView.builder(
          itemCount: searched.isNotEmpty ? searched.length : task.length,
          itemBuilder: (context, index) {
            if (searched.isNotEmpty) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => TaskDetailPage(task: task[index]));
                },
                child: TaskCard(
                    title: searched[index].name!,
                    category: searched[index].category!,
                    level: searched[index].level!,
                    clock: searched[index].date!),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Get.to(() => TaskDetailPage(task: task[index]));
                },
                child: TaskCard(
                    title: task[index].name!,
                    category: task[index].category!,
                    level: task[index].level!,
                    clock: task[index].date!),
              );
            }
          },
        ),
      ),
    );
  }

  Widget searchField(List<TaskModel> task, bool isSearch) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: defaultMargin / 2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: TextField(
        controller: search,
        autofocus: isSearch,
        decoration: InputDecoration(
          hintText: 'Cari tugas kamu disini',
          prefixIcon: Image.asset('assets/Search.png'),
          border: InputBorder.none,
          hintStyle:
              subtitleTextStyle.copyWith(fontWeight: regular, fontSize: 14),
        ),
        onChanged: (value) {
          setState(() {
            searched = task.where((task) {
              final taskName = task.name!.toLowerCase();
              final input = value.toLowerCase();
              return taskName.contains(input);
            }).toList();
          });
        },
      ),
    );
  }
}
