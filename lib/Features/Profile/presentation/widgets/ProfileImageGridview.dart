import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';

import '../../../Post/data/models/PostModel.dart';

class Profileimagegridview extends StatelessWidget {
  const Profileimagegridview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      if (state is ProfilePostLoadedSuccess) {
        return GridView.builder(
          itemCount: state.posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4),
          itemBuilder: (context, index) {
            PostModel posts = state.posts[index];
            return GestureDetector(
              onTap: () {
                context.push(ConstantRouter.SinglePhotoView, extra: posts);
              },
              child: Container(
                height: 300.h,
                width: double.infinity,
                child: Image.network(
                  posts.imageURL ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } else {
        return Center(child: Text("No Posts"));
      }
    });
  }
}
