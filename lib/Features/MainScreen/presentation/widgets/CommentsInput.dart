import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Post/presentation/manager/comment_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';

class CommentsInput extends StatelessWidget {
  final String postId;
  const CommentsInput({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: context.read<CommentCubit>().commentController,
          decoration: InputDecoration(
            hintText: "add comment .....",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        )),
        BlocBuilder<CommentCubit, CommentState>(
          builder: (context, state) {
            if (state is CreateCommentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return IconButton(
                onPressed: () {
                  final currentUser = context.read<ProfileCubit>().currentUser;
                  if (currentUser != null) {
                    BlocProvider.of<CommentCubit>(context)
                        .createComment(postId, currentUser);
                    context.read<CommentCubit>().commentController.clear();
                  }
                },
                icon: Icon(
                  Icons.send_outlined,
                  color: Colors.black,
                  size: 30,
                ));
          },
        )
      ],
    );
  }
}
