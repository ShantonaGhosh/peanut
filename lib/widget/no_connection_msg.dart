// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:peanut/widget/custom_button.dart';
import 'package:peanut/widget/my_text_style.dart';

class NoConnectionMsg extends StatelessWidget {
  const NoConnectionMsg({
    Key? key, // Add the missing key parameter
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        bool isLandscape = size.width > size.height;

        return Container(
          height: isLandscape ? size.height * 0.7 : size.height * 0.9,
          width: isLandscape ? size.width * 0.7 : size.width * 0.9,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/network.png",
                  width: isLandscape ? size.width * 0.40 : size.width * 0.60,
                ),
                Column(
                  children: [
                    Text(
                      "Opps!",
                      style: myTextStyle(
                        size: 22.0,
                        clr: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Looks like something went wrong",
                        style: myTextStyle(
                          size: 16.0,
                          clr: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      onTap: onTap,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 08.0),
                      title: 'Refresh',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
