import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';

import '../../../../Core/Routes/ConstantRouter.dart';

class AddDescriptionScreen extends StatelessWidget {
  const AddDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postCubit = context.read<PostsCubit>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          'New post',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                if(state is CreatePostLoading){
                  return CircularProgressIndicator();
                }
                return GestureDetector(
                  onTap: () {

                    final currentUser = context
                        .read<ProfileCubit>()
                        .currentUser!;
                    if (currentUser != null) {
                      postCubit.createPost(currentUser);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: User not found"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<PostsCubit, PostsState>(listener: (context, state) {
        if (state is CreatePostSuccess) {
          context.read<ProfileCubit>().getUserData();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Post Created Successfully!"),
              backgroundColor: Colors.green,
            ),
          );
          context.push(ConstantRouter.mainScreen);
        } else if (state is CreatePostFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${state.ErrorMessage}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }, builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Container(
                  decoration:
                  BoxDecoration(color: Color.fromARGB(255, 236, 236, 224)),
                  child: Row(
                    children: [
                      Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Image.file(
                          postCubit.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      SizedBox(
                          width: 230.w,
                          height: 40.h,
                          child: TextField(
                              controller: postCubit.descriptionController,
                              decoration: const InputDecoration(
                                hintText: 'Write a caption ...',
                                border: InputBorder.none,
                              )))
                    ],
                  ),
                ),
              ),

              /*if (postCubit.profileImage != null)
                  Image.file(postCubit.profileImage!,
                      height: 200, width: 200, fit: BoxFit.cover)*/
            ],
          ),
        );
      }),
    );
  }
}
