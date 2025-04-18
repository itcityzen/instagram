import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/widgets/ProfileView.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
        if (state is ProfileUpdated) {
          debugPrint("Profile Updated");
          BlocProvider.of<ProfileCubit>(context).getUserData();
        }
      }, builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoadedSuccess) {
          debugPrint("builder user profile");
          return ProfileView(user: state.user);
        } else if (state is ProfileLoadedFailure) {
          return Center(child: Text(state.ErrorMessage));
        } else {
          return Center(child: Text("Error 5als"));
        }
      }),
    );
  }
}
