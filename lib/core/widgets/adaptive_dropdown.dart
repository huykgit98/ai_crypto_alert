import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class AdaptiveDropdown<T> extends StatelessWidget {
  const AdaptiveDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.itemLabelBuilder,
    required this.onChanged,
  });
  final List<T> items;
  final T selectedItem;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoPicker(context)
        : _buildDropdownButton(context);
  }

  Widget _buildCupertinoPicker(BuildContext context) {
    final selectedIndex = items.indexOf(selectedItem);
    T? tempSelectedItem = selectedItem;

    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 250,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: context.moonColors?.textPrimary)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: Text('Done',
                            style: TextStyle(
                              color: context.moonColors?.textPrimary,
                              // fontWeight: FontWeight.w600,
                            )),
                        onPressed: () {
                          onChanged(tempSelectedItem);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32.0,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedIndex,
                      ),
                      onSelectedItemChanged: (int index) {
                        tempSelectedItem = items[index];
                      },
                      children: items
                          .map((item) => Text(itemLabelBuilder(item)))
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: context.moonColors?.raditz,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(itemLabelBuilder(selectedItem),
              style: context.moonTypography?.heading.text14),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: context.moonColors?.raditz,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<T>(
        value: selectedItem,
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabelBuilder(item)),
                ))
            .toList(),
        isExpanded: true,
        underline: const SizedBox(
          height: 0,
        ),
      ),
    );
  }
}
