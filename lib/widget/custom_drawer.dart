import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/service/auth_services.dart';
import '../common/app_color.dart';

import 'my_text_style.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 180,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  menulist(
                    onTap: () => Get.offAllNamed("/route"),
                    title: "Home",
                    icon: Icons.home_outlined,
                  ),
                  menulist(
                    onTap: () {
                      AuthServices().logOut();
                    },
                    title: "Log Out",
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  menulist({
    String? title,
    IconData? icon,
    required VoidCallback onTap,
  }) {
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
              Icon(icon, color: kPrimaryColor),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                title ?? '',
                style: myTextStyle(clr: Colors.black54, size: 16.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
