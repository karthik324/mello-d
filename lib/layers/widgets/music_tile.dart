import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/styles/app_styles.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    super.key,
    required this.artist,
    required this.title,
    required this.heroTag,
    required this.controller,
    required this.id,
  });

  final String title;
  final String artist;
  final String heroTag;
  final int id;
  final OnAudioQuery controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Hero(
                tag: heroTag,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: QueryArtworkWidget(
                    controller: controller,
                    id: id,
                    type: ArtworkType.AUDIO,
                  ),
                ),
              ),
              3.width(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width - 125,
                    child: Text(
                      title,
                      style: AppStyles.semiBold,
                    ),
                  ),
                  Text(artist, style: AppStyles.medium),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.more_horiz,
          ),
        ],
      ),
    );
  }
}
