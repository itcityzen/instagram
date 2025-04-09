import '../../../Register/data/models/UserModel.dart';
import '../models/Room Model.dart';

abstract class ChatRepository {
  Future<String> CreateNewRoom(String anotherID);
  Stream<List<ChatRoomModel>> getAllRooms(String currentUserID);
  Future<UserModel> getUserData(String uid);


}
