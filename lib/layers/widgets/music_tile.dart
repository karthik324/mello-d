import 'package:flutter/material.dart';
import 'package:mello_d/extensions/int_extension.dart';
import 'package:mello_d/layers/styles/app_styles.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    super.key,
    required this.artist,
    required this.image,
    required this.title,
    required this.heroTag,
  });

  final String title;
  final String artist;
  final String image;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Hero(
                tag: heroTag ,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
              3.width(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppStyles.semiBold),
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
