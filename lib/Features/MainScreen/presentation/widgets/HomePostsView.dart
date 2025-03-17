import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Post/data/models/PostModel.dart';

class Homepostsview extends StatelessWidget {
  final PostModel posts;

  const Homepostsview({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: 375.w,
          height: 30.h,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: 20.r,
              child: SizedBox(
                width: 35.w,
                height: 35.h,
                child: Image.network(
                  fit: BoxFit.contain,
                  posts.profileUrl ?? "No Image",
                ),
              ),
            ),
            title: Text(
              posts.username ?? "no username",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.more_horiz),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: 255.h,
              width: 375.w,
              child: Image.network(
                posts.imageURL ?? "",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 14.w,
                ),
                Icon(
                  Icons.favorite_outline,
                  size: 28.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                Icon(
                  Icons.chat_bubble_outline,
                  size: 25.w,
                ),
                SizedBox(
                  width: 17.w,
                ),
                Icon(
                  Icons.send,
                  size: 27.w,
                ),
                Spacer(),
                Icon(
                  Icons.bookmark_border,
                  size: 27.w,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  posts.username ?? "no username",
                  style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 13.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  posts.description ?? "no description",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 15.h),
          ],
        )
      ],
    );
  }
}
