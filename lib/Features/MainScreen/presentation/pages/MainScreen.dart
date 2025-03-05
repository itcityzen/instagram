import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/MainScreen/presentation/pages/ReelsScreen.dart';
import 'package:instagram2/Features/Profile/presentation/pages/ProfileScreens.dart';

import '../../../Post/presentation/pages/AddPostScreen.dart';
import 'HomeScreen.dart';
import '../../../Profile/presentation/widgets/ProfileView.dart';
import 'SearchScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late PageController pageController;

  void onPageChanged(int Page) {
    setState(() {
      currentIndex = Page;
    });
  }

  void NavigationTap(int Page) {
    pageController.jumpToPage(Page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            currentIndex: currentIndex,
            onTap: NavigationTap,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_box_sharp,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_collection,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 35,
                  ),
                  label: "")
            ]),
      ),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        children: [
          HomeScreen(),
          SearchScreen(),
          AddPostScreen(),
          ReelsScreen(),
          ProfileScreens()
        ],
      ),
    );
  }
}
