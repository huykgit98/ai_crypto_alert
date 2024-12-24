import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class TabContentWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const TabContentWidget({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: items.map((item) {
        return MoonMenuItem(
          backgroundColor: context.moonColors!.goku,
          height: 60,
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            print('Tapped on ${item['label']}');
          },
          label: Text(item['label'] as String),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'] as IconData,
              color: Colors.orange,
            ),
          ),
          trailing: Text(
            item['amount'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}
