import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

Future<dynamic> bottomSheetBuilder({
  required BuildContext context,
  required Widget child,
  double? height,
  RouteSettings? settings,
  Duration transitionDuration = const Duration(milliseconds: 200),
  bool useRootNavigator = true,
}) {
  return showMoonModalBottomSheet(
    context: context,
    transitionDuration: transitionDuration,
    height: height ?? MediaQuery.of(context).size.height * 0.4,
    settings: settings,
    builder: (BuildContext context) => child,
    useRootNavigator: useRootNavigator,
  );
}
