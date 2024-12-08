import 'dart:io';

import 'package:easy_refresh/easy_refresh.dart';

Header getPlatformSpecificHeader() {
  if (Platform.isIOS) {
    return const CupertinoHeader(
      position: IndicatorPosition.locator,
      triggerOffset: 0,
    );
  } else {
    return const MaterialHeader(
      position: IndicatorPosition.locator,
    );
  }
}
