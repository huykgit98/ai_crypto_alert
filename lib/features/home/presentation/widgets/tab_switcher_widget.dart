import 'package:flutter/material.dart';

class TabSwitcherWidget extends StatelessWidget {
  const TabSwitcherWidget({
    required this.selectedTab,
    required this.onTabSelected,
    Key? key,
  }) : super(key: key);
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onTabSelected(0),
          child: Column(
            children: [
              Text(
                'Danh mục con',
                style: TextStyle(
                  color: selectedTab == 0 ? Colors.pink : Colors.grey,
                  fontWeight:
                      selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (selectedTab == 0)
                Container(
                  height: 2,
                  width: 40,
                  color: Colors.pink,
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => onTabSelected(1),
          child: Column(
            children: [
              Text(
                'Danh mục cha',
                style: TextStyle(
                  color: selectedTab == 1 ? Colors.pink : Colors.grey,
                  fontWeight:
                      selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (selectedTab == 1)
                Container(
                  height: 2,
                  width: 40,
                  color: Colors.pink,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
