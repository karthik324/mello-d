import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/bloc/home/home_bloc.dart';
import 'package:mello_d/layers/bloc/home/home_state.dart';
import 'package:mello_d/layers/routes/app_routes.dart';
import 'package:mello_d/layers/styles/app_colors.dart';
import 'package:mello_d/layers/styles/app_styles.dart';
import 'package:mello_d/layers/widgets/custom_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PlayMusicScreen extends StatelessWidget {
  const PlayMusicScreen({
    super.key,
    required this.controller,
    required this.hero,
    required this.song,
  });

  final OnAudioQuery controller;
  final SongModel song;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  width: double.maxFinite,
                ),
                3.height(context),
                Text(
                  song.title,
                  style: AppStyles.medium.copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  song.artist ?? 'Unknown',
                  style: AppStyles.regular.copyWith(
                    fontSize: 15,
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                // 3.height(context),
              ],
            ),
            Column(
              children: [
                Hero(
                  tag: hero,
                  child: BlocBuilder<MusicBloc, MusicState>(
                    builder: (context, state) {
                      return SleekCircularSlider(
                        min: 0,
                        max: state is PlayMusicState ? state.maxDuration : 100, 
                        initialValue: state is PlayMusicState ? state.value : 0,
                        appearance: CircularSliderAppearance(
                          size: size.width - 30,
                          customColors: CustomSliderColors(
                            progressBarColor: AppColors.mainColor,
                            dynamicGradient: false,
                            hideShadow: true,
                            shadowColor: AppColors.grey,
                            trackColor: AppColors.mainColor.withOpacity(0.1),
                          ),
                          customWidths: CustomSliderWidths(
                            progressBarWidth: 10,
                          ),
                        ),
                        onChange: (value) {
                          context.read<MusicBloc>().changeDurationToSec(value.toInt());
                        },
                        innerWidget: (val) => Container(
                          padding: const EdgeInsets.all(20),
                          width: size.width * 0.85,
                          height: size.width - 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(170),
                            child: QueryArtworkWidget(
                              quality: 100,
                              nullArtworkWidget: Icon(
                                CupertinoIcons.music_note,
                                color: AppColors.black,
                              ),
                              controller: controller,
                              id: song.id,
                              type: ArtworkType.AUDIO,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<MusicBloc, MusicState>(
                  builder: (context, state) {
                    if (state is PlayMusicState) {
                      return Text(
                        '${state.position} | ${state.duration}',
                      );
                    }
                    return const Text('00:00 | 00:00');
                  },
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      CupertinoIcons.shuffle,
                      size: 25,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 40,
                      ),
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: AppColors.mainColor,
                      child: Transform.scale(
                        scale: 2.5,
                        child: IconButton(
                          onPressed: () {
                            if (context.read<MusicBloc>().isPlaying) {
                              print('not playing');
                              context.read<MusicBloc>().pauseMusic(song.uri ?? '');
                            } else {
                              context.read<MusicBloc>().playMusic(song.uri ?? '');
                            }
                          },
                          icon: BlocBuilder<MusicBloc, MusicState>(
                            builder: (context, state) {
                              if (state is PlayMusicState) {
                                return Icon(
                                  state.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                                  color: AppColors.white,
                                );
                              } else if (state is PauseMusicState) {
                                return Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.white,
                                );
                              }
                              return Icon(Icons.play_arrow_rounded, color: AppColors.white);
                            },
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_next,
                        size: 40,
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      size: 25,
                      color: AppColors.mainColor,
                    ),
                  ],
                ),
                4.height(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
