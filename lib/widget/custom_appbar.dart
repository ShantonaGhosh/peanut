// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../common/app_color.dart';
import 'my_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    key,
    this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading,
  })  : preferredSize = const Size.fromHeight(55.0),
        super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kPrimaryColor,
      title: title ??
          Text(
            "Peanut",
            style: myTextStyle(fw: FontWeight.w600),
          ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      actions: actions ??
          [
            const SizedBox(
              width: 20.0,
            ),
          ],
      elevation: 0.0,
    );
  }
}
