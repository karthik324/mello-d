import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/styles/app_colors.dart';
import 'package:mello_d/layers/styles/app_images.dart';
import 'package:mello_d/layers/styles/app_styles.dart';
import 'package:mello_d/layers/widgets/divider_horizontal.dart';
import 'package:mello_d/layers/widgets/music_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(size.width * 0.025),
          child: const CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage(
              AppImages.profilePlaceHolder,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(size.width * 0.025),
            child: CircleAvatar(
              radius: 14,
              backgroundImage: const AssetImage(AppImages.settings),
              backgroundColor: AppColors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CarouselView(),
          1.height(context),
          const LightGreyDivisionHori(),
          2.height(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                child: const RecentlyPlayedView(),
              ),
              2.height(context),
              const LightGreyDivisionHori(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Musical Selections',
                      style: AppStyles.extraBold,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RecentlyPlayedView extends StatelessWidget {
  const RecentlyPlayedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Played',
          style: AppStyles.extraBold,
        ),
        1.height(context),
        const Column(
          children: [
            MusicTile(
              artist: 'Travis Scott',
              image: AppImages.travisScottPlaceHolder,
              title: 'Highest in the room',
            ),
            MusicTile(
              artist: 'Home',
              image: AppImages.resonancePlaceHolder,
              title: 'Resonance',
            ),
            MusicTile(
              artist: 'Strawberry Guy',
              image: AppImages.strawBerryGuyPlaceHolder,
              title: 'What would I do',
            ),
          ],
        ),
      ],
    );
  }
}

class CarouselView extends StatelessWidget {
  const CarouselView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: Colors.primaries[Random().nextInt(
                  Colors.primaries.length,
                )],
                borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
