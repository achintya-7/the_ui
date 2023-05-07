// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:the_ui/screens/travel_app/models/recommender.dart';

class ImagePlace extends StatelessWidget {
  ImagePlace({
    Key? key,
    required this.recommended,
  }) : super(key: key);

  final Recommended recommended;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    preLoadImage(recommended, context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              recommended.images!.length,
              (int index) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        CachedNetworkImageProvider(recommended.images![index]),
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

preLoadImage(Recommended recommended, BuildContext context) {
  for (String image in recommended.images!) {
    precacheImage(
      CachedNetworkImageProvider(image),
      context,
    );
  }
}
