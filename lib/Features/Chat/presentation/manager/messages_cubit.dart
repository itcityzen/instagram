import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram2/Features/Chat/data/repositories/ChatRepository.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../Core/DependcyInjection/DependcyInjection.dart';
import '../../data/models/Messages Model.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  ChatRepository chatRepository;
  MessagesCubit(this.chatRepository) : super(MessagesInitial());

  StreamSubscription<List<MessageModel>>? streamSubscription;
  TextEditingController textEditingController = TextEditingController();
  final currentUser = getIt<FirebaseAuth>().currentUser!.uid;

  Future<void> SendMessage(
      {required String roomId, required String anotherUserId}) async {
    emit(SendMessagesLoading());
    try {
      MessageModel message = MessageModel(
          text: textEditingController.text,
          userId: currentUser,
          anotherUserId: anotherUserId,
          messageId: Uuid().v1(),
          createdAt: Timestamp.now(),
          isSeen: false);
      await chatRepository.SendingMessages(roomId: roomId, message: message);
      emit(SendMessagesSuccess());
      startListeningtoMessages(roomId);
    } catch (e) {
      emit(SendMessagesError(e.toString()));
    }
  }

  void startListeningtoMessages(String roomId) {
    try {
      emit(MessagesLoading());
      streamSubscription =
          chatRepository.getMessagesForRoom(roomId).listen((messages) {
        emit(MessagesLoadedSuccess(messages));
      }, onError: (error) {
        emit(MessagesLoadedError(error.toString()));
      });
    } catch (e) {
      emit(MessagesLoadedError("Error to get Messages ${e.toString()}"));
    }
  }
}
