import 'package:flutter/cupertino.dart';

class AppRoutes {
  static Future<void> goTo({
    required BuildContext context,
    required Widget screen,
    bool fromBottomToUp = false,
  }) {
    return Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: fromBottomToUp,
        builder: (ctx) {
          return screen;
        },
      ),
    );
  }

  static void back({required BuildContext context, void state}) {
    return Navigator.pop(context, [state]);
  }
}
