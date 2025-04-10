import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Chat/presentation/manager/rooms_cubit.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
    //     BlocProvider.of<RoomsCubit>(context).getAllRooms(); if it registerfactory 
    context.read<RoomsCubit>().getAllRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1.h,
      ),
      body: BlocBuilder<RoomsCubit, RoomsState>(builder: (context, state) {
        if (state is getRoomLoadedError) {
          return Center(child: Text(state.message));
        }
        if (state is getRoomLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is getRoomLoadedSuccess) {
          return ListView.builder(
              itemCount: state.chatRooms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(state.chatRooms[index].anotherUserData!.username!),
                  // null check  Text(room.lastMessage ?? ''), 
                  subtitle: Text(state.chatRooms[index].lastMessage!),
                  leading: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage(
                        state.chatRooms[index].anotherUserData!.profileUrl!),
                  ),
                  trailing: Text(
                    state.chatRooms[index].createdAt!.toDate().toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    context.push(ConstantRouter.MessagesScreen, extra: {
                      "roomId": state.chatRooms[index].roomid,
                      "anotherUserId":
                          state.chatRooms[index].anotherUserData!.uid,
                      "anotherUserName":
                          state.chatRooms[index].anotherUserData!.username
                    });
                  },
                );
              });
        }
        return Center(child: Text("Something went wrong"));
      }),
    );
  }
}
