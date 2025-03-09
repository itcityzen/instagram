import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';

import '../../../Register/data/models/UserModel.dart';

class Profileviewbasics extends StatelessWidget {
  final UserModel user;

  const Profileviewbasics({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: SizedBox(
                        width: 80.w,
                        height: 72.h,
                        child: Image.network(
                          user.profileUrl ?? "No Image",
                        )),
                  )),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Text(
                        user.totalPosts.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(width: 45.w),
                      Text(
                        user.totalFollowers.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(width: 70.w),
                      Text(
                        user.totalFollowing.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Text(
                        'posts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                      SizedBox(width: 25.w),
                      Text(
                        'followers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                      SizedBox(width: 19.w),
                      Text(
                        'following',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username ?? "No Name",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  user.bio ?? "No Bio",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  user.website ?? "No Website",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.topCenter,
                height: 31.5.h,
                width: 200.w,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: Colors.black87, width: 2.w)),
                child: TextButton(
                  onPressed: () {
                    context.push(ConstantRouter.editScreen);
                  },
                  child: Text(
                    'Edit profile',
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w900,
                        fontSize: 14.5.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
