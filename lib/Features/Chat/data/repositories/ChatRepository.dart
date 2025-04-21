import '../../../Register/data/models/UserModel.dart';
import '../models/Messages Model.dart';
import '../models/RoomModel.dart';

abstract class ChatRepository {
  Future<String> CreateNewRoom(String anotherID);
  Stream<List<ChatRoomModel>> getAllRooms(String currentUserID);
  Future<UserModel> getUserData(String uid);
  Future<void> SendingMessages({
    required String roomId,
    required MessageModel message,
  });
  Stream<List<MessageModel>> getMessagesForRoom(String roomId);
}
