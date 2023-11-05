import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/routes/app_routes.dart';
import 'package:mello_d/layers/styles/app_colors.dart';
import 'package:mello_d/layers/styles/app_styles.dart';
import 'package:mello_d/layers/widgets/custom_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayMusicScreen extends StatelessWidget {
  const PlayMusicScreen({
    super.key,
    required this.artist,
    required this.controller,
    required this.id,
    required this.songName,
    required this.hero,
  });

  final String artist;
  final String songName;
  final OnAudioQuery controller;
  final int id;
  final String hero;

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
            songName,
            style: AppStyles.medium.copyWith(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            artist,
            style: AppStyles.regular.copyWith(
              fontSize: 15,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          5.height(context),
          Hero(
            tag: hero,
            // child: Container(
            //   width: size.width * 0.85,
            //   height: size.width - 50,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: AssetImage(
            //         AppImages.travisScottPlaceHolder,
            //       ),
            //     ),
            //   ),
            // ),
            child: SizedBox(
                width: size.width * 0.85,
                height: size.width - 50,
              child: QueryArtworkWidget(
                controller: controller,
                id: id,
                type: ArtworkType.AUDIO,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
