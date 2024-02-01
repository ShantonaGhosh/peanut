import 'package:flutter/material.dart';

import '../common/app_color.dart';
import 'my_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.btnColor,
    this.elevation,
    this.fontSize,
    this.minWidth,
    this.padding,
    this.fontColor,
    required this.onTap, this.redius,
  });
  final String? title;
  final double? fontSize;
  final Color? fontColor;
  final EdgeInsetsGeometry? padding;
  final double? minWidth;
  final double? elevation;
  final Color? btnColor;
  final VoidCallback onTap;
  final double? redius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      
      onPressed: onTap,
  
      color: btnColor ?? kPrimaryColor,
      minWidth: minWidth,
      shape:   RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(redius?? 30.0),
      ),
    
      elevation: elevation ?? 4.0,
      child: Text(
        title ?? '',
        style: myTextStyle(
            size: fontSize ?? 18.0, clr:  fontColor ?? Colors.white, fw: FontWeight.w600),
      ),
    );
  }
}
