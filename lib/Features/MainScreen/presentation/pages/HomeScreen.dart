import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(       appBar: AppBar(
      centerTitle: false,
      title: SizedBox(
        height: 40.h,
        width: 105.w,
        child: Image.asset(
          'assets/instag-removebg-preview.png',
          fit: BoxFit.fitHeight,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
              size: 35,
            )),
        SizedBox(
          width: 1.w,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              size: 35,
            ))
      ],
    ),

    );
  }
}
