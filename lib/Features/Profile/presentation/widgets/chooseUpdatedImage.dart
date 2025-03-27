import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Register/presentation/manager/register_cubit.dart';

class ChooseUpdatedImage extends StatelessWidget {
  ChooseUpdatedImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final ImagePicker picker = ImagePicker();

    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Wrap(children: [
//Take a Photo
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Take a Photo"),
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.camera);
                        if (pickedFile != null) {
                          cubit.setImage(File(pickedFile.path));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Error picking image: ${e.toString()}")),
                        );
                      }
                    },
                  ),

                  // Choose photo from Gallery

                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Choose from Gallery"),
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          cubit.setImage(File(pickedFile.path));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Error picking image: ${e.toString()}")),
                        );
                      }
                    },
                  ),
                ]),
              );
            });
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return CircleAvatar(
          radius: 70.r,
          child: cubit.profileImage == null
              ? Container(
                  width: 180.w,
                  height: 200.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      cubit.currentUser!.profileUrl!,
                      height: 200.h,
                      width: 200.h,
                      fit: BoxFit.fill,
                    ),
                  ))
              : null,
        );
      }),
    );
  }
}
