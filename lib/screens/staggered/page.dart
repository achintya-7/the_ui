import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(_selectedIndex, _onItemTapped),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Text("Hi there!", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            const Text(
              "What do you want \nto learn today",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            courseLayout(context),
          ],
        ),
      ),
    );
  }
}

Widget bottomBar(int selectedIndex, Function(int) onItemTapped) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house_fill),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.play_fill),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_fill),
        label: '',
      ),
    ],
    currentIndex: selectedIndex,
    selectedItemColor: const Color(0xff042456),
    unselectedItemColor: const Color(0xffD3DEFA),
    onTap: onItemTapped,
  );
}

Widget courseLayout(BuildContext context) {
  List images = [
    "go.png",
    "nodejs.png",
    "dart.png",
    "flutter.png",
    "firebase.png",
    "postgres.png",
    "react.png",
    "vue.png",
  ];

  return MasonryGridView.count(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 2,
    mainAxisSpacing: 23,
    crossAxisSpacing: 27,
    itemCount: images.length,
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset("assets/${images[index]}"),
      );
    },
  );
}
