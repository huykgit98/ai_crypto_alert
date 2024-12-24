import 'package:flutter/material.dart';

class TabContentWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const TabContentWidget({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return ListTile(
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
          title: Text(item['label'] as String),
          trailing: Text(
            item['amount'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            print('Tapped on ${item['label']}');
          },
        );
      }).toList(),
    );
  }
}
