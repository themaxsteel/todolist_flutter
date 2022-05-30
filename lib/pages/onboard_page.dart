import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/pages/login_page.dart';
import 'package:todo_list_flutter/theme.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/Logo.png',
                height: 20,
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: 'Manage your task with ',
                  style:
                      blackTextStyle.copyWith(fontWeight: bold, fontSize: 30),
                  children: [
                    TextSpan(
                      text: 'TodoList',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 30),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset('assets/Frame 4.png'),
              ),
              const SizedBox(height: 30),
              Text(
                'Manage your task Looking at the table, it\nbecomes clear that the cloud data center\nLooking at the table.',
                style: subtitleTextStyle.copyWith(
                    fontWeight: medium, fontSize: 13),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginPage());
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
                    "Let's Start",
                    style:
                        whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
