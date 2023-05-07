import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_ui/screens/travel_app/models/popular.dart';
import 'package:the_ui/screens/travel_app/models/recommender.dart';

class TravelHomePage extends StatelessWidget {
  TravelHomePage({super.key});

  final _pageController = PageController(viewportFraction: 0.8);

  Future<List<Recommended>> _loadData() async {
    final String jsonStr =
        await rootBundle.loadString('assets/travel/json/recommended.json');
    final jsonMap = json.decode(jsonStr) as List<dynamic>;
    return jsonMap.map((e) => Recommended.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // App Drawer
            appDrawer(context),

            // Title
            title(),

            // Tabs
            tabs(),

            // PageView
            pageView(_pageController, _loadData()),

            // Popular Categories
            popularText(),

            // List of Popular Categories
            popularCategories(),
          ],
        ),
      ),
    );
  }
}

Widget popularCategories() => Container(
      margin: const EdgeInsets.only(top: 15),
      height: 45,
      child: ListView.builder(
          itemCount: populars.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 28.8, right: 9.6),
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 19.2),
                height: 45.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.6),
                  color: Color(populars[index].color),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 19.2,
                    ),
                    Image.asset(
                      populars[index].image,
                      height: 16.8,
                    ),
                    const SizedBox(
                      width: 19.2,
                    )
                  ],
                ),
              )),
    );

Widget popularText() => Padding(
      padding: const EdgeInsets.only(top: 8, left: 28, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Popular Categories",
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Show All",
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );

Widget tabs() => Container(
      height: 30,
      margin: const EdgeInsets.only(top: 18, left: 14),
      child: DefaultTabController(
        length: 4,
        child: TabBar(
          labelPadding: const EdgeInsets.symmetric(horizontal: 14),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 14),
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle:
              GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 2, color: Colors.black),
            insets: EdgeInsets.symmetric(horizontal: 20),
          ),
          tabs: const [
            Tab(text: 'Recommended'),
            Tab(text: 'Popular'),
            Tab(text: 'New Destination'),
            Tab(text: 'Hidden Gems'),
          ],
        ),
      ),
    );

Widget title() => Padding(
      padding: const EdgeInsets.only(top: 22, left: 28),
      child: Text(
        "Explore \nthe Nature",
        style: GoogleFonts.playfairDisplay(
          fontSize: 45,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

Widget appDrawer(BuildContext context) => Container(
      height: 60,
      margin: const EdgeInsets.only(
        top: 16,
        left: 28,
        right: 28,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: svgIcon('assets/travel/svg/icon_drawer.svg'),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          svgIcon('assets/travel/svg/icon_search.svg'),
        ],
      ),
    );

Widget svgIcon(String asset) => Container(
      height: 55,
      width: 55,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(
        asset,
        height: 20,
        width: 20,
      ),
    );

FutureBuilder<List<Recommended>> pageView(
        PageController pageController, Future<List<Recommended>> loadData) =>
    FutureBuilder<List<Recommended>>(
      future: loadData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(18.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final List<Recommended> recommended = snapshot.data;
        return futureResponseWidget(pageController, recommended);
      },
    );

Widget futureResponseWidget(
        PageController pageController, List<Recommended> recommended) =>
    Container(
      height: 220,
      margin: const EdgeInsets.only(top: 18),
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          recommended.length,
          (index) => imagePageView(
            recommended[index],
          ),
        ),
      ),
    );

Widget imagePageView(Recommended recommended) => Container(
      margin: const EdgeInsets.only(right: 28),
      width: 330,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(recommended.image!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 20,
                ),
                child: Container(
                  height: 36,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  color: Colors.black.withOpacity(0.1),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/travel/svg/icon_location.svg'),
                      const SizedBox(width: 8),
                      Text(
                        recommended.name!,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
