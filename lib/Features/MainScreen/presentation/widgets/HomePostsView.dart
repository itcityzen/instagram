import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram2/Features/MainScreen/presentation/widgets/CommentsInput.dart';
import 'package:instagram2/Features/MainScreen/presentation/widgets/CommentsLists.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';

import '../../../../Core/DependcyInjection/DependcyInjection.dart';
import '../../../Post/data/models/PostModel.dart';
import '../../../Post/presentation/manager/comment_cubit.dart';

class Homepostsview extends StatelessWidget {
  final PostModel posts;

  const Homepostsview({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    var currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
    var isLiked = posts.likes?.contains(currentUserID) ?? false;

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
                child: InkWell(
                  onDoubleTap: () {
                    context.read<PostsCubit>().Tablike(posts.postID!, !isLiked);
                  },
                  child: Image.network(
                    fit: BoxFit.contain,
                    posts.profileUrl ?? "No Image",
                  ),
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
                IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline,
                      color: isLiked ? Colors.red : Colors.black,
                      size: 28.w,
                    ),
                    onPressed: () {
                      context
                          .read<PostsCubit>()
                          .Tablike(posts.postID!, !isLiked);
                    }),
                Text(
                  "${posts.totalLikes ?? 0} likes",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 11.w,
                ),
                IconButton(
                  onPressed: () {
                    _showBottomSheet(context, posts.postID!);
                  },
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 25.w,
                  ),
                ),
                Text(
                  "${posts.totalComments ?? 0} comments",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
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

  void _showBottomSheet(BuildContext context, String postid) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt<CommentCubit>(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Display list of comments
                Expanded(child: CommentsList(postId: postid)),
                // Input widget for creating new comment
                CommentsInput(
                  postId: postid,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
