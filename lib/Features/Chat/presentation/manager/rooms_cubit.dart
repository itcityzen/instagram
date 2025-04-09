import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram2/Core/DependcyInjection/DependcyInjection.dart';
import 'package:instagram2/Features/Chat/data/repositories/ChatRepository.dart';
import 'package:instagram2/Features/register/data/models/UserModel.dart';
import 'package:meta/meta.dart';

import '../../data/models/Room Model.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  ChatRepository chatRepository;
  RoomsCubit(this.chatRepository) : super(RoomsInitial());

  Future<String?> createRoom(String anotherUserID) async {
    emit(CreateRoomLoading());
    try {
      final roomID = chatRepository.CreateNewRoom(anotherUserID);
      emit(CreateRoomSuccess());
      return roomID;
    } catch (e) {
      emit(CreateRoomError(e.toString()));
      return null;
    }
  }

  final currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
  StreamSubscription<List<ChatRoomModel>>? streamSubscription;

  getAllRooms() {
    emit(getRoomLoading());
    streamSubscription =
        chatRepository.getAllRooms(currentUserID).listen((Rooms) async {
      List<ChatRoomModel> updatedRooms = [];
      for (var room in Rooms) {
        final anotherID = room.members!.firstWhere((id) => id != currentUserID);
        final anotherUserData = await chatRepository.getUserData(anotherID);
        room.anotherUserData = anotherUserData as UserModel?;
        updatedRooms.add(room);
      }
      emit(getRoomLoadedSuccess(updatedRooms));
    }, onError: (error) {
      emit(getRoomLoadedError(error.toString()));
    });
  }
}
