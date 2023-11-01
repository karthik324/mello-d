import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/routes/app_routes.dart';
import 'package:mello_d/layers/styles/app_colors.dart';
import 'package:mello_d/layers/styles/app_images.dart';
import 'package:mello_d/layers/styles/app_styles.dart';
import 'package:mello_d/layers/widgets/custom_app_bar.dart';

class PlayMusicScreen extends StatelessWidget {
  const PlayMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leading: InkWell(
          onTap: () {
            AppRoutes.back(context: context);
          },
          child: const Icon(
            Icons.keyboard_arrow_down,
          ),
        ),
        context: context,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.maxFinite,
          ),
          3.height(context),
          Text(
            'Highest In the room',
            style: AppStyles.medium.copyWith(
              fontSize: 20,
            ),
          ),
          Text(
            'Travis Scott',
            style: AppStyles.regular.copyWith(
              fontSize: 15,
              color: AppColors.grey,
            ),
          ),
          5.height(context),
          Hero(
            tag: 'hero',
            child: Container(
              width: size.width * 0.85,
              height: size.width - 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppImages.travisScottPlaceHolder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
