import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/pages/home_page.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/theme.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TaskProvider provider = Provider.of<TaskProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.asset(
                  'assets/Logo.png',
                  height: 18,
                  alignment: Alignment.topLeft,
                ),
                const SizedBox(height: 50),
                Text(
                  'Manage your tasks\nwith us',
                  style:
                      blackTextStyle.copyWith(fontWeight: bold, fontSize: 30),
                ),
                const SizedBox(height: 30),
                Text(
                  'Username',
                  style:
                      titleTextStyle.copyWith(fontWeight: medium, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextFormField(
                    controller: username,
                    style: subtitleTextStyle.copyWith(
                        fontWeight: regular, fontSize: 13),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input your username...',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null && value.length < 3) {
                        return 'Please enter min. 3 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Password',
                  style:
                      titleTextStyle.copyWith(fontWeight: medium, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    style: subtitleTextStyle.copyWith(
                        fontWeight: regular, fontSize: 13),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input your password...',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null && value.length < 6) {
                        return 'Please enter min. 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await Provider.of<TaskProvider>(context, listen: false)
                          .getTask();
                      provider.setName(username.text);
                      Get.off(() => const HomePage());
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 100),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Log In",
                      style: whiteTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
