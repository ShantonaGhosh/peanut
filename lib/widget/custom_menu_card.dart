import 'package:flutter/material.dart';


import 'my_text_style.dart';

class CustomMenuCard extends StatelessWidget {
  const CustomMenuCard({
    super.key,
    this.icon,
    this.iconSize,
    this.title,
    this.titleSize,
    required this.onTap,
    this.cardColor,
  });

  final IconData? icon;
  final double? iconSize;
  final String? title;
  final double? titleSize;
  final VoidCallback onTap;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardColor,
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: Colors.black45,
              ),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: myTextStyle(
                  size: titleSize,
                  clr: Colors.black54,
                  fw: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
