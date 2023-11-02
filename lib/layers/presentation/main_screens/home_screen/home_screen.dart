import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/presentation/sub_screens/play_music_screen/play_music_screen.dart';
import 'package:mello_d/layers/routes/app_routes.dart';
import 'package:mello_d/layers/styles/app_colors.dart';
import 'package:mello_d/layers/styles/app_images.dart';
import 'package:mello_d/layers/styles/app_styles.dart';
import 'package:mello_d/layers/widgets/custom_app_bar.dart';
import 'package:mello_d/layers/widgets/divider_horizontal.dart';
import 'package:mello_d/layers/widgets/music_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leading: const CircleAvatar(
          radius: 14,
          backgroundImage: AssetImage(
            AppImages.profilePlaceHolder,
          ),
        ),
        context: context,
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
      body: ListView(
        children: [
          const CarouselView(),
          1.height(context),
          const LightGreyDivisionHori(),
          2.height(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
                child: const RecentlyPlayedView(),
              ),
              !_hasPermission
                  ? noAccessToLibraryWidget()
                  : FutureBuilder<List<SongModel>>(
                      // Default values:
                      future: _audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true,
                      ),
                      builder: (context, item) {
                        // Display error, if any.
                        if (item.hasError) {
                          return Text(item.error.toString());
                        }

                        // Waiting content.
                        if (item.data == null) {
                          return const CircularProgressIndicator();
                        }

                        // 'Library' is empty.
                        if (item.data!.isEmpty) return const Text("Nothing found!");

                        // You can use [item.data!] direct or you can create a:
                        // List<SongModel> songs = item.data!;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: item.data!.length,
                          itemBuilder: (context, index) {
                            return MusicTile(
                              artist: item.data?[index].artist ?? 'Unknown',
                              controller: _audioQuery,
                              heroTag: 'Hero',
                              title: item.data?[index].title ?? 'Unknown',
                              id: item.data?[index].id ?? 0,
                            );
                          },
                        );
                      },
                    ),
              2.height(context),
              const LightGreyDivisionHori(),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.025),
                child: MusicalSelectionView(size: size),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}

class MusicalSelectionView extends StatelessWidget {
  const MusicalSelectionView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Musical Selections',
          style: AppStyles.extraBold,
        ),
        1.height(context),
        Container(
          margin: EdgeInsets.only(bottom: size.width * 0.025),
          height: 150,
          width: double.maxFinite,
          child: ListView(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: 100,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      height: 20,
                      width: size.width * 0.4,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      // margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 20,
                      width: size.width * 0.4,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      // margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: size.width * 0.025),
                height: 100,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
                ),
              ),
            ],
          ),
        ),
      ],
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
        Column(
          children: [
            // InkWell(
            //   borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
            //   onTap: () {
            //     AppRoutes.goTo(
            //       context: context,
            //       fromBottomToUp: true,
            //       screen: const PlayMusicScreen(),
            //     );
            //   },
            //   // child: const Padding(
            //   //   padding: EdgeInsets.all(4),
            //   //   child: MusicTile(
            //   //     heroTag: 'hero',
            //   //     artist: 'Travis Scott',
            //   //     image: AppImages.travisScottPlaceHolder,
            //   //     title: 'Highest in the room',
            //   //   ),
            //   // ),
            // ),
            // const MusicTile(
            //   heroTag: 'hah',
            //   artist: 'Home',
            //   image: AppImages.resonancePlaceHolder,
            //   title: 'Resonance',
            // ),
            // const MusicTile(
            //   heroTag: 'asdasdf',
            //   artist: 'Strawberry Guy',
            //   image: AppImages.strawBerryGuyPlaceHolder,
            //   title: 'What would I do',
            // ),
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
