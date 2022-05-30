import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task_model.dart';
import 'package:todo_list_flutter/pages/home_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';

class EditTaskPage extends StatelessWidget {
  EditTaskPage({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List day = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Saturday'
    ];
    TaskProvider provider = Provider.of<TaskProvider>(context, listen: false);
    provider.category = task.category == 'Works' ? 0 : 1;
    provider.level = task.level == 'Easy'
        ? 0
        : task.level == 'Medium'
            ? 1
            : 2;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('Edit Task'),
        ),
        body: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: ListView(
            children: [
              inputName(),
              const SizedBox(height: 15),
              selectCategory(),
              const SizedBox(height: 15),
              selectLevel(),
              const SizedBox(height: 15),
              selectDay(provider, day),
              const SizedBox(height: 30),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: task.name!,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider.setCategory(0);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: provider.category == 0
                            ? primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Works',
                        textAlign: TextAlign.center,
                        style: provider.category == 0
                            ? whiteTextStyle.copyWith(
                                fontWeight: regular, fontSize: 14)
                            : subtitleTextStyle.copyWith(
                                fontWeight: regular, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider.setCategory(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: provider.category == 1
                            ? primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Routines',
                        textAlign: TextAlign.center,
                        style: provider.category == 1
                            ? whiteTextStyle.copyWith(
                                fontWeight: regular, fontSize: 14)
                            : subtitleTextStyle.copyWith(
                                fontWeight: regular, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget selectLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Level',
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider.setLevel(0);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: provider.level == 0 ? easyColor : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Easy',
                        textAlign: TextAlign.center,
                        style: provider.level == 0
                            ? whiteTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              )
                            : subtitleTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider.setLevel(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: provider.level == 1 ? mediumColor : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Medium',
                        textAlign: TextAlign.center,
                        style: provider.level == 1
                            ? whiteTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              )
                            : subtitleTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider.setLevel(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: provider.level == 2 ? hardColor : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Hard',
                        textAlign: TextAlign.center,
                        style: provider.level == 2
                            ? whiteTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              )
                            : subtitleTextStyle.copyWith(
                                fontWeight: regular,
                                fontSize: 14,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget selectDay(TaskProvider provider, List<dynamic> day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Day',
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 16,
          ),
        ),
        DropdownButtonFormField(
          onChanged: (value) {
            provider.setDate(value.toString());
          },
          value: 'Sunday',
          items: day
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: titleTextStyle.copyWith(
                        fontWeight: medium, fontSize: 14),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget submitButton() {
    return Consumer<TaskProvider>(builder: (context, provider, child) {
      return provider.isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  bool response = await provider.updateTask(int.parse(task.id!),
                      name.text != '' ? name.text : task.name!);
                  if (response) {
                    Get.off(() => const HomePage());
                  } else {
                    Get.snackbar('Error', 'Something went wrong');
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style:
                      whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                ),
              ),
            );
    });
  }
}
