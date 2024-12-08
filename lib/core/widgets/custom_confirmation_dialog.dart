import 'dart:io';

import 'package:ai_crypto_alert/core/enums/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:moon_design/moon_design.dart';

class AdaptiveConfirmDialog extends StatelessWidget {
  const AdaptiveConfirmDialog({
    required this.content,
    required this.onConfirm,
    this.title,
    this.cancelLabel,
    this.confirmLabel,
    this.dialogType = DialogType.info, // Default to 'info' type
    this.cancelLabelColor,
    this.confirmLabelColor,
    super.key,
  });

  final String? title;
  final String content;
  final String? cancelLabel;
  final String? confirmLabel;
  final VoidCallback onConfirm;
  final DialogType dialogType;
  final Color? cancelLabelColor;
  final Color? confirmLabelColor;

  @override
  Widget build(BuildContext context) {
    final dialogTitle = title ?? '';
    final dialogIcon = _dialogIcon();
    final backgroundColor = _dialogBackgroundColor(context);

    return PlatformAlertDialog(
      title: Platform.isIOS
          ? Center(
              child: Text(dialogTitle),
            )
          : Column(
              children: [
                Icon(dialogIcon, color: backgroundColor),
                Text(
                  dialogTitle,
                  maxLines: 3,
                ),
              ],
            ),
      material: (context, platform) => MaterialAlertDialogData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: <Widget>[
          if (cancelLabel != null)
            MoonButton(
              label: Text(
                cancelLabel!,
                style: TextStyle(
                    color: cancelLabelColor ?? context.moonColors?.textPrimary),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          if (confirmLabel != null)
            MoonFilledButton(
              buttonSize: MoonButtonSize.sm,
              onTap: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              label: Text(
                confirmLabel!,
                style: TextStyle(color: confirmLabelColor),
              ),
              backgroundColor: backgroundColor,
            ),
        ],
      ),
      cupertino: (context, platform) => CupertinoAlertDialogData(
        actions: <CupertinoDialogAction>[
          if (cancelLabel != null)
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                cancelLabel!,
                style: TextStyle(color: cancelLabelColor ?? Colors.blue),
              ),
            ),
          if (confirmLabel != null)
            CupertinoDialogAction(
              isDestructiveAction: dialogType == DialogType.error,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(
                confirmLabel!,
                style: TextStyle(color: confirmLabelColor ?? Colors.blue),
              ),
            ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
    );
  }

  IconData _dialogIcon() {
    switch (dialogType) {
      case DialogType.error:
        return Icons.error;
      case DialogType.info:
        return Icons.info;
      case DialogType.success:
        return Icons.check_circle;
      case DialogType.warning:
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Color _dialogBackgroundColor(BuildContext context) {
    switch (dialogType) {
      case DialogType.error:
        return Colors.red;
      case DialogType.info:
        return context.moonColors?.frieza ?? Colors.green;
      case DialogType.success:
        return Colors.green;
      case DialogType.warning:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}
