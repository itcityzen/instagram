import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Post/presentation/widgets/AddPostScreen.dart';
import 'package:instagram2/Features/Post/presentation/widgets/AddReelsScreen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
      body: SafeArea(
          child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: onPageChanged,
            controller: pageController,
            children: [AddPostScreen(), AddReelsScreen()],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: 10.h,
            right: currentIndex == 0 ? 100.w : 150.w,
            left: currentIndex == 1 ? 100.w : 150.w,
            child: Container(
              width: 120.w,
              height: 35.h,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationTap(0);
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              currentIndex == 0 ? Colors.white : Colors.grey),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationTap(1);
                    },
                    child: Text(
                      'Reels',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              currentIndex == 1 ? Colors.white : Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
