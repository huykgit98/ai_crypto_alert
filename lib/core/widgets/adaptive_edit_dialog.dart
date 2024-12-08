import 'dart:io';

import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class AdaptiveEditDialog extends StatefulWidget {
  const AdaptiveEditDialog({
    super.key,
    required this.title,
    this.initialValue = '',
    this.hintText = '',
  });
  final String title;
  final String initialValue;
  final String hintText;

  @override
  State<AdaptiveEditDialog> createState() => _AdaptiveEditDialogState();
}

class _AdaptiveEditDialogState extends State<AdaptiveEditDialog> {
  late TextEditingController _controller;
  final buttonTextStyle = const TextStyle(
    color: Colors.blue,
    fontSize: 14,
    letterSpacing: 1.2,
  );
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog(context);
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Column(
        children: [
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: _controller,
            placeholder: widget.hintText,
            cursorColor: context.moonColors?.textPrimary,
            style: TextStyle(color: context.moonColors?.textPrimary),
            autofocus: true,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel'.hardcoded, style: buttonTextStyle),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text(
            'OK'.hardcoded,
            style: buttonTextStyle,
          ),
          onPressed: () {
            Navigator.pop(context, _controller.text);
          },
        ),
      ],
    );
  }

  Widget _buildMaterialDialog(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: MoonFormTextInput(
        controller: _controller,
        cursorColor: context.moonColors?.textPrimary,
        hintText: widget.hintText,
        // decoration: InputDecoration(
        //   hintText: widget.hintText,
        //   hintStyle: TextStyle(
        //       color: context.moonColors?.textSecondary,
        //       fontWeight: FontWeight.w400),
        //   focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //       color: context.moonColors!.textPrimary,
        //     ),
        //   ),
        // ),
        autofocus: true,
      ),
      actions: [
        MoonButton(
          buttonSize: MoonButtonSize.sm,
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          label: const Text(
            'Cancel',
          ),
        ),
        MoonFilledButton(
          buttonSize: MoonButtonSize.sm,
          onTap: () {
            Navigator.pop(context, _controller.text);
          },
          label: Text(
            'OK',
          ),
          backgroundColor: Colors.green,
        ),
      ],
    );
  }
}
