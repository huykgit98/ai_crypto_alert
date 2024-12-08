import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VibrationUtil {
  static void vibrate(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      HapticFeedback.selectionClick();
    }
  }
}
