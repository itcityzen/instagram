import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';

import '../../../../Core/DependcyInjection/DependcyInjection.dart';
import '../manager/profile_cubit.dart';

class Singlephotoview extends StatelessWidget {
  PostModel posts;

  Singlephotoview({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    var currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
    var isLiked = posts.likes?.contains(currentUserID) ?? false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
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
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
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
                          isLiked ? Icons.favorite : Icons.favorite_outline,
                          color: isLiked ? Colors.red : Colors.black,
                          size: 28.w,
                        ),
                        Text(
                          "${posts.totalLikes ?? 0} likes",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 13.sp),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          posts.description ?? "no description",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
