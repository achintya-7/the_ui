// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          // Page View
          pageView(_pageController, recommended),

          // App Bar
          SafeArea(child: appBar(context)),

          // Place Info
          placeInfo(context, recommended, _pageController),
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

Widget pageView(PageController pageController, Recommended recommended) =>
    PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: List.generate(
        recommended.images!.length,
        (int index) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(recommended.images![index]),
            ),
          ),
        ),
      ),
    );

Widget appBar(BuildContext context) => Builder(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.5),
              ),
              child: SvgPicture.asset('assets/travel/svg/icon_left_arrow.svg'),
            ),
          ),
        );
      },
    );

Widget placeInfo(BuildContext context, Recommended recommended,
        PageController pageController) =>
    Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.4,
            maxHeight: MediaQuery.of(context).size.height * 0.5),
        padding: const EdgeInsets.only(left: 30, bottom: 45, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Paging Info
            pagingInfo(recommended.images!.length, pageController),

            // Tag Line
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                recommended.tagLine!,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                recommended.description!,
                maxLines: 7,
                overflow: TextOverflow.fade,
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ),

            const Spacer(),

            // Bottom Bar
            bottomBar(recommended),
          ],
        ),
      ),
    );

Widget pagingInfo(int length, PageController pageController) =>
    SmoothPageIndicator(
      controller: pageController,
      count: length,
      effect: const ExpandingDotsEffect(
          activeDotColor: Color(0xFFFFFFFF),
          dotColor: Color(0xFFababab),
          dotHeight: 4.8,
          dotWidth: 6,
          spacing: 4.8),
    );

Widget bottomBar(Recommended recommended) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              child: Text(
                'Start from',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
            FittedBox(
              child: Text(
                '\$ ${recommended.price.toString()} / person',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700, color: Colors.white),
              ),
            )
          ],
        ),
        Container(
          height: 62.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.6), color: Colors.white),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(left: 28.8, right: 28.8),
              child: FittedBox(
                child: Text(
                  'Explore Now >>',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
