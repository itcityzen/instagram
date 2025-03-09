import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';

class AddDescriptionScreen extends StatelessWidget {
  const AddDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postCubit = context.read<PostsCubit>();

    return Scaffold(
      body: BlocConsumer<PostsCubit, PostsState>(listener: (context, state) {
        if (state is CreatePostSuccess) {
          context.read<ProfileCubit>().getUserData();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Post Created Successfully!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (postCubit.profileImage != null)
                Image.file(postCubit.profileImage!,
                    height: 200, width: 200, fit: BoxFit.cover),
              SizedBox(height: 20.h), //  add description
              TextFormField(
                controller: postCubit.descriptionController,
                decoration: InputDecoration(
                  labelText: "Add a description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                  onPressed: () {
                    final currentUser =
                        context.read<ProfileCubit>().currentUser!;
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
                  child: Text('Share'))
            ],
          ),
        );
      }),
    );
  }
}
