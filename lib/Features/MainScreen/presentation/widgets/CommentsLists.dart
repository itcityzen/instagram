import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Features/Post/presentation/manager/comment_cubit.dart';

class CommentsList extends StatefulWidget {
  final String postId;
  const CommentsList({super.key, required this.postId});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentCubit>(context).getComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(builder: (context, state) {
      if (state is CommentLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CommentLoadedSuccess) {
        if (state.comments.isEmpty) {
          return Center(child: Text("No Comments Yet"));
        }
        return ListView.builder(
          itemCount: state.comments.length,
          itemBuilder: (context, index) {
            final comment = state.comments[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(comment.userProfileUrl!),
              ),
              title: Text(comment.username!),
              subtitle: Text(comment.comment!),
              trailing: Text(comment.createdAt!.toDate().toString()),
            );
          },
        );
      }
      if (state is CommentLoadedError) {
        return Center(child: Text(state.errorMessage));
      }
      return Center(child: Text("Something went wrong"));
    });
  }
}
