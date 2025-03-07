import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<File> allimages = [];

  final List<Widget> media = [];

  File? animage;

  int currentPage = 0;

  int? lastPage;
  @override
  void initState() {
    super.initState();
    FetchNewMedia();
  }

  void FetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();

    if (permission.isAuth) {
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
      );
      final List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: currentPage, size: 60);

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            allimages.add(File(file.path));
            animage = allimages[0];
          }
        }
      }
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
              future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }),
        );
      }
      setState(() {
        media.addAll(temp as Iterable<AssetEntity>);
        currentPage++;
      });
    }
  }

  int indexx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'New Post',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () {}, //add to router and set image to cubit},
                child: Text(
                  'Next',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            SizedBox(
              height: 375.h,
              child: GridView.builder(
                  itemCount: media.isEmpty ? media.length : 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  itemBuilder: (context, index) {
                    return media[indexx];
                  }),
            ),
            Container(
              width: double.infinity,
              height: 40.h,
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Recent',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                itemCount: media.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        indexx = index;
                        animage = allimages[index];
                      });
                    },
                    child: media[index],
                  );
                })
          ],
        ))));
  }
}
