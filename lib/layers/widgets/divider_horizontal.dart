import 'package:flutter/material.dart';
import 'package:mello_d/layers/styles/app_colors.dart';

class LightGreyDivisionHori extends StatelessWidget {
  const LightGreyDivisionHori({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.grey.withOpacity(0.1),
    );
  }
}