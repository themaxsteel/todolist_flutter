import 'package:flutter/material.dart';
import 'package:todo_list_flutter/theme.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final void Function() ontap;

  const CategoryCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 170,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(imageUrl), alignment: Alignment.bottomRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: titleTextStyle.copyWith(fontWeight: bold, fontSize: 14),
              ),
              Text(
                subtitle,
                style: subtitleTextStyle.copyWith(
                    fontWeight: medium, fontSize: 11),
              )
            ],
          ),
        ),
      ),
    );
  }
}
