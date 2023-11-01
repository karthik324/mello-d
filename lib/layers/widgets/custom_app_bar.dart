import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required Widget leading,
    required BuildContext context,
    List<Widget>? actions,
  }) : super(
          leading: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            child: leading,
          ),
          actions: actions,
        );
}
