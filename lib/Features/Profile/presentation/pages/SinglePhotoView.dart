import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';

import '../manager/profile_cubit.dart';

class Singlephotoview extends StatelessWidget {
  PostModel posts;

  Singlephotoview({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
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
                        Icon(Icons.favorite),
                        Icon(Icons.message_sharp)
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(posts.description ?? "no description")
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
