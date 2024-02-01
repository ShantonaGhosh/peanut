import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import '../common/app_color.dart';

// ignore: use_key_in_widget_constructors
class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 80.0,
      itemBuilder: (context, index) {
        final colors = [
          const Color(0xffC8E6C9),
          kPrimaryColor,
        ];
        final color = colors[index % colors.length];
        return DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
      },
    );
  }
}
