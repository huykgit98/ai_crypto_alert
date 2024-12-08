import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:moon_design/moon_design.dart';

Future<DateTime?> showAdaptiveDatePicker(BuildContext context,
    {String? cancelText, String? confirmText, DateTime? initialValue}) async {
  if (Platform.isIOS) {
    return showDatePickerWithCustomCupertino(context,
        initialValue: initialValue);
  } else {
    return showMaterialDatePicker(context, initialValue: initialValue);
  }
}

Future<DateTime?> showMaterialDatePicker(BuildContext context,
    {String? cancelText, String? confirmText, DateTime? initialValue}) async {
  final now = DateUtils.dateOnly(DateTime.now());
  final firstDate = DateTime(2024);
  final lastDate = now.add(const Duration(days: 365));

  return showDatePicker(
    context: context,
    initialDate: initialValue ?? now,
    firstDate: firstDate,
    lastDate: lastDate,
    cancelText: cancelText,
    confirmText: confirmText,
  );
}

Future<DateTime?> showDatePickerWithCustomCupertino(BuildContext context,
    {String? cancelText, String? confirmText, DateTime? initialValue}) async {
  final now = DateUtils.dateOnly(DateTime.now());
  final firstDate = DateTime(2024);
  final lastDate = now.add(const Duration(days: 365));
  var selectedDate = now;

  final date = await showPlatformDatePicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: initialValue ?? now,
    cupertinoContentBuilder: (
      contentData,
      _,
    ) =>
        StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        final contentData = DatePickerContentData(
          initialDate: initialValue ?? now,
          firstDate: firstDate,
          lastDate: lastDate,
          selectedDate: selectedDate,
        );

        return _CustomCupertinoDatePicker(
          cancelLabel: cancelText,
          doneLabel: confirmText,
          contentData: contentData,
          onDateTimeChanged: (newDate) =>
              setState(() => selectedDate = newDate),
        );
      },
    ),
  );

  if (date != null) {
    return date;
  }
}

class _CustomCupertinoDatePicker extends StatelessWidget {
  const _CustomCupertinoDatePicker({
    required this.contentData,
    required this.onDateTimeChanged,
    // ignore: unused_element
    this.data,
    // ignore: unused_element
    this.modalColor,
    // ignore: unused_element
    this.modalHeight = 300,
    // ignore: unused_element
    this.mode = CupertinoDatePickerMode.date,
    // ignore: unused_element
    this.doneLabel,
    // ignore: unused_element
    this.cancelLabel,
    super.key,
  });
  final double modalHeight;
  final Color? modalColor;
  final CupertinoDatePickerMode mode;
  final DatePickerContentData contentData;
  final ValueChanged<DateTime> onDateTimeChanged;
  final CupertinoDatePickerData? data;
  final String? doneLabel;
  final String? cancelLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: modalHeight,
      color: modalColor ?? Theme.of(context).canvasColor,
      child: Stack(
        children: [
          CupertinoDatePicker(
            key: data?.key,
            mode: data?.mode ?? mode,
            onDateTimeChanged: (value) {
              data?.onDateTimeChanged?.call(value);
              onDateTimeChanged.call(value);
            },
            initialDateTime: contentData.initialDate,
            minimumDate: contentData.firstDate,
            maximumDate: contentData.lastDate,
            backgroundColor: data?.backgroundColor,
            dateOrder: data?.dateOrder,
            maximumYear: data?.maximumYear,
            minimumYear: data?.minimumYear ?? 1,
            minuteInterval: data?.minuteInterval ?? 1,
            use24hFormat: data?.use24hFormat ?? false,
          ),
          Row(
            children: [
              PlatformTextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(cancelLabel ?? 'Cancel',
                    style: TextStyle(color: context.moonColors?.textPrimary)),
              ),
              const Spacer(),
              Text(
                DateFormat('dd/MM/yyyy').format(contentData.selectedDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              PlatformTextButton(
                onPressed: () {
                  Navigator.pop(context, contentData.selectedDate);
                },
                child: Text(doneLabel ?? 'Done',
                    style: TextStyle(color: context.moonColors?.textPrimary)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
