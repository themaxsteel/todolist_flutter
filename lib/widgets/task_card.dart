import 'package:flutter/material.dart';
import 'package:todo_list_flutter/theme.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String category;
  final String level;
  final String clock;

  const TaskCard(
      {Key? key,
      required this.title,
      required this.category,
      required this.level,
      required this.clock})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: titleTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 58,
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  color: level == 'Easy'
                      ? easyColor
                      : level == 'Medium'
                          ? mediumColor
                          : hardColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  level,
                  textAlign: TextAlign.center,
                  style:
                      whiteTextStyle.copyWith(fontWeight: medium, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            category,
            style: subtitleTextStyle.copyWith(fontWeight: medium, fontSize: 11),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Image.asset('assets/Time Circle.png', height: 13),
              const SizedBox(width: 6),
              Text(
                clock,
                style: subtitleTextStyle.copyWith(
                    fontWeight: medium, fontSize: 11),
              )
            ],
          )
        ],
      ),
    );
  }
}
