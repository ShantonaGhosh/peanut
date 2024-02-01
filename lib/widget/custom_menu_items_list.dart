import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../common/app_color.dart';
import 'custom_menu_card.dart';
import 'my_text_style.dart';

class CustomMenuItemsList extends StatelessWidget {
  const CustomMenuItemsList({
    super.key,
    required this.itemList,
    this.heading,
  });
  final List itemList;
  final String? heading;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$heading",
            style: myTextStyle(size: 20.0, clr: kPrimaryColor),
          ),
          const Divider(
            thickness: 1.0,
            height: 8,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: itemList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size.width > 400 ? 4 : 3,
              crossAxisSpacing: size.width > 400 ? 6.0 : 10.0,
              mainAxisSpacing: size.width > 400 ? 6.0 : 10.0,
              // childAspectRatio: 1,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var item = itemList[index];
              return LayoutBuilder(
                builder: (_, constraints) => CustomMenuCard(
                  onTap: () {
                    Get.toNamed('${item['page']}');
                  },
                  cardColor: const Color.fromARGB(255, 219, 239, 253),
                  icon: item['icon'],
                  title: item['title'],
                  titleSize: constraints.minWidth * 0.12,
                  iconSize: constraints.minWidth * 0.30,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
