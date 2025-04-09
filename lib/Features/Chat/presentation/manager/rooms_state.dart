part of 'rooms_cubit.dart';

@immutable
sealed class RoomsState {}

final class RoomsInitial extends RoomsState {}

class CreateRoomLoading extends RoomsState {}

class CreateRoomSuccess extends RoomsState {}

class CreateRoomError extends RoomsState {
  final String error;
  CreateRoomError(this.error);
}

class getRoomLoading extends RoomsState {}

class getRoomLoadedSuccess extends RoomsState {
  final List<ChatRoomModel> chatRooms;

  getRoomLoadedSuccess(this.chatRooms);
}

class getRoomLoadedError extends RoomsState {
  final String message;

  getRoomLoadedError(this.message);
}
