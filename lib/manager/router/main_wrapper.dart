import 'package:flutter/material.dart';

import '../../presentation/explore/explore_screen.dart';
import '../../presentation/fab_screen/fab_screen.dart';
import '../../presentation/feed/screen/feed_shared_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/setting/setting_screen.dart';
import '../color.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: IndexedStack(
          index: selectedIndex,
          children: const <Widget>[
            HomeScreen(),
            SearchScreen(), // Changed from SearchScreen to ExploreScreen
            FabScreen(),
            FeedSharedScreen(),
            SettingScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark ? TAppColor.darkFadeBlueColor : TAppColor.whiteGreyColor,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        iconSize: 30,
        selectedItemColor: TAppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Explore", // Changed label from "Search" to "Explore"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_outlined),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "User",
          ),
        ],
      ),
    );
  }
}
