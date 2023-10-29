import 'package:flutter/cupertino.dart';

extension ViewPortExtension on int {
  SizedBox height(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * this / 100);
  }

  SizedBox width(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width * this / 100);
  }
}
