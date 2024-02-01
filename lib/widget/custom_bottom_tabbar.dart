
import 'package:flutter/material.dart';

import '../common/app_color.dart';

class CustomBottomTabBar extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const CustomBottomTabBar({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomTabBarState createState() => _CustomBottomTabBarState();
}

class _CustomBottomTabBarState extends State<CustomBottomTabBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      shape: const CircularNotchedRectangle(),
      color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: const Icon(Icons.home),
          ),
        
          buildTabItem(
            index: 1,
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Widget icon,
  }) {
    final isSelected = index == widget.index;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.white : kPrimaryColor,
      ),
      child: IconButton(
        onPressed: () {
          widget.onChangedTab(index);
        },
        padding: const EdgeInsets.all(8.0),
        constraints: const BoxConstraints(maxHeight: 46.0, minHeight: 46),
        icon: icon,
        color: isSelected ? kPrimaryColor : Colors.white,
      ),
    );
  }
}
