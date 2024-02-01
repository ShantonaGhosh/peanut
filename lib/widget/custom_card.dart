
import 'package:flutter/material.dart';



import '../common/app_color.dart';

import 'my_text_style.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      this.title,
      this.icon,
      this.firstText,
      
      this.onTap,
      this.color});

  String? title;
  IconData? icon;
  Widget? firstText;
  VoidCallback? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
         color: Colors.grey.shade100,
         

          ),
          child: Row(
            children: [
              firstText ??
                  Icon(
                    icon,
                    color: kPrimaryColor,
                  ),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                title ?? '',
                style: myTextStyle(clr: Colors.black54, size: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
