import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/widgets/ProfileViewBasics.dart';
import 'package:instagram2/Features/Profile/presentation/widgets/Tabs.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';

class ProfileView extends StatelessWidget {
  final UserModel user;

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Profileviewbasics(user: user),
          ),
          SliverToBoxAdapter(
            child: Tabs(),
          ),
          SliverFillRemaining(
            child: TabBarView(children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PostLoadedSuccess) {
                  return GridView.builder(
                    itemCount: state.posts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3),
                    itemBuilder: (context, index) {
                      PostModel posts = state.posts[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Image.network(
                          posts.imageURL ?? "",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No Posts"));
                }
              }),
              Center(child: Text("Reels")),
              Center(
                child: Text("Saved"),
              )
            ]),
          )
        ],
      )),
    );
  }
}
