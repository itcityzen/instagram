import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Profile/presentation/manager/follow_cubit.dart';
import 'package:instagram2/Features/Search/presentation/manager/anothe_user_cubit.dart';

import '../../../Register/data/models/UserModel.dart';

class Profileviewbasics extends StatefulWidget {
  final UserModel user;

  const Profileviewbasics({super.key, required this.user});

  @override
  State<Profileviewbasics> createState() => _ProfileviewbasicsState();
}

class _ProfileviewbasicsState extends State<Profileviewbasics> {
  late bool isFollowing;
  late String currentUserId;
  @override
  void initState() {
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    isFollowing = (widget.user.followers?.contains(currentUserId) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 85.w,
                  height: 80.h,
                  child: ClipOval(
                      child: Image.network(
                    widget.user.profileUrl ?? "No Image",
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Text(
                        widget.user.totalPosts.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(width: 45.w),
                      Text(
                        widget.user.totalFollowers.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(width: 70.w),
                      Text(
                        widget.user.totalFollowing.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Text(
                        'Posts'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                      SizedBox(width: 25.w),
                      TextButton(
                        onPressed: () {
                          context
                              .read<FollowCubit>()
                              .followersandfollowings(widget.user.followers!);
                          context.push(ConstantRouter.FollowScreen);
                        },
                        child: Text(
                          'Followers'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(width: 19.w),
                      TextButton(
                        onPressed: () {
                          context
                              .read<FollowCubit>()
                              .followersandfollowings(widget.user.following!);
                          context.push(ConstantRouter.FollowScreen);
                        },
                        child: Text(
                          'Following'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
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
                  widget.user.username ?? "No Name",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  widget.user.bio ?? "No Bio",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  widget.user.website ?? "No Website",
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
              child: widget.user.uid == FirebaseAuth.instance.currentUser?.uid
                  ? Container(
                      alignment: Alignment.topCenter,
                      height: 31.5.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5.r),
                          border:
                              Border.all(color: Colors.black87, width: 2.w)),
                      child: TextButton(
                        onPressed: () {
                          context.push(ConstantRouter.editScreen);
                        },
                        child: Text(
                          'Edit Profile'.tr(),
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w900,
                              fontSize: 14.5.sp),
                        ),
                      ))
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: 31.5.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5.r),
                            border:
                                Border.all(color: Colors.black87, width: 2.w)),
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<AnotherUserCubit>()
                                .getFollow(widget.user.uid!);
                            setState(() {
                              isFollowing = !isFollowing;
                            });
                          },
                          child: Text(
                            isFollowing ? 'Following' : 'Follow',
                            style: TextStyle(
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w900,
                                fontSize: 14.5.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 31.5.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5.r),
                            border:
                                Border.all(color: Colors.black87, width: 2.w)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Message',
                            style: TextStyle(
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w900,
                                fontSize: 14.5.sp),
                          ),
                        ),
                      )
                    ]),
            ),
          ),
        ],
      ),
    );
  }
}
