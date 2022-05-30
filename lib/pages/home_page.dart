import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/pages/add_task_page.dart';
import 'package:todo_list_flutter/pages/all_task_page.dart';
import 'package:todo_list_flutter/pages/onboard_page.dart';
import 'package:todo_list_flutter/pages/routine_page.dart';
import 'package:todo_list_flutter/pages/task_detail_page.dart';
import 'package:todo_list_flutter/pages/work_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';
import 'package:todo_list_flutter/widgets/category_card.dart';
import 'package:todo_list_flutter/widgets/task_card.dart';

enum MenuItem {
  logout,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskProvider provider = Provider.of<TaskProvider>(context);
    List<TaskModel> task = provider.task;
    String name = provider.name;

    List works = task.where((task) {
      return task.category!.contains('Works');
    }).toList();

    List routines = task.where((task) {
      return task.category!.contains('Routines');
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: floatingButton(),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await provider.getTask();
        },
        child: ListView(
          addAutomaticKeepAlives: false,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  SizedBox(height: defaultMargin),
                  header(task, name),
                  const SizedBox(height: 30),
                  search(provider),
                  const SizedBox(height: 35),
                  categoryMenu(routines, works),
                  const SizedBox(height: 35),
                  allTask(task),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingButton() {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        Get.to(() => AddTaskPage());
      },
    );
  }

  Widget header(List<TaskModel> task, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi $name',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20),
            ),
            const SizedBox(height: 2),
            Text(
              task.length >= 2
                  ? task.length.toString() + ' Tasks waiting'
                  : task.length.toString() + ' Task waiting',
              style:
                  primaryTextStyle.copyWith(fontWeight: medium, fontSize: 12),
            ),
          ],
        ),
        PopupMenuButton(
            onSelected: (value) {
              if (value == MenuItem.logout) {
                Get.offAll(() => const OnBoardPage());
              }
            },
            padding: const EdgeInsets.all(5),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: MenuItem.logout,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    'Log Out',
                    style: blackTextStyle.copyWith(
                        fontSize: 13, fontWeight: regular),
                  ),
                ),
              ];
            })
      ],
    );
  }

  Widget search(TaskProvider provider) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Cari tugas kamu disini',
                prefixIcon: Image.asset('assets/Search.png'),
                border: InputBorder.none,
                hintStyle: subtitleTextStyle.copyWith(
                    fontWeight: regular, fontSize: 14),
              ),
              onTap: () {
                Get.to(() => AllTaskPage(isSearch: true));
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset('assets/Filter.png'),
        )
      ],
    );
  }

  Widget categoryMenu(List routines, List works) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CategoryCard(
                ontap: () {
                  Get.to(() => const RoutinePage());
                },
                title: 'Routines',
                subtitle: routines.length.toString() + ' Tasks',
                imageUrl: 'assets/routine.png'),
            const SizedBox(width: 15),
            CategoryCard(
                ontap: () {
                  Get.to(() => const WorkPage());
                },
                title: 'Works',
                subtitle: works.length.toString() + ' Tasks',
                imageUrl: 'assets/work.png'),
          ],
        ),
      ],
    );
  }

  Widget allTask(List<TaskModel> task) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All Task',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => AllTaskPage(isSearch: false));
              },
              child: Text(
                'See All',
                style:
                    primaryTextStyle.copyWith(fontWeight: medium, fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              if (task.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => TaskDetailPage(
                          task: task[index],
                        ));
                  },
                  child: TaskCard(
                      title: task[index].name!,
                      category: task[index].category!,
                      level: task[index].level!,
                      clock: task[index].date!),
                );
              } else {
                return Container(
                  color: Colors.red,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            })
      ],
    );
  }
}
