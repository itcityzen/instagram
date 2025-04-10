import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram2/Core/DependcyInjection/DependcyInjection.dart';
import 'package:instagram2/Features/Chat/data/models/Messages%20Model.dart';
import 'package:instagram2/Features/Chat/data/models/Room%20Model.dart';
import 'package:instagram2/Features/Chat/data/repositories/ChatRepository.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImplementation extends ChatRepository {
  FirebaseFirestore firestore;

  ChatRepositoryImplementation(this.firestore);

  @override
  Future<String> CreateNewRoom(String anotherID) async {
    try {
      final currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
      final sortedMembers = [currentUserID, anotherID]
        ..sort((a, b) => a.compareTo(b));

      // checking if room is already exists
      final existingRoom = await firestore
          .collection("Rooms")
          .where("members", isEqualTo: sortedMembers)
          .get();
      if (existingRoom.docs.isNotEmpty) {
        return existingRoom.docs.first.id;
      }
      ChatRoomModel chatRoom = ChatRoomModel(
        roomid: Uuid().v1(),
        members: sortedMembers,
        lastMessage: '',
        createdAt: Timestamp.now(),
        totalUnReadMessages: 0,
      );
      await firestore
          .collection("Rooms")
          .doc(chatRoom.roomid)
          .set(chatRoom.toFirestore());
      return chatRoom.roomid!;
    } catch (e) {
      throw Exception("Error to create Room ${e.toString()}");
    }
  }

  @override
  Stream<List<ChatRoomModel>> getAllRooms(String currentUserID) {
    try {
      final chatRoomsCollection = firestore.collection("Rooms").orderBy(
            "createdAt",
            descending: true,
          );
      // divided all each room into a snapshot
      return chatRoomsCollection.snapshots().map((snapshot) {
// convert documents into lists
        final allRooms = snapshot.docs
            .map((doc) => ChatRoomModel.fromFirestore(doc.data()))
            .toList();
        // get all my rooms only
        return allRooms
            .where((room) => room.members!.contains(currentUserID))
            .toList();
      });
    } catch (e) {
      throw Exception("Error to get Rooms ${e.toString()}");
    }
  }

  @override
  Future<UserModel> getUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection("Users").doc(uid).get();
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        return UserModel.fromFirestore(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error to get User ${e.toString()}");
    }
  }

  @override
  Future<void> SendingMessages({
    required String roomId,
    required MessageModel message,
  }) async {
    try {
      final messageDoc = firestore
          .collection("Rooms")
          .doc(roomId)
          .collection("Messages")
          .doc(message.messageId)
          .set(message.toFirestore());

      // Update last message + time in the room doc
      await firestore.collection("Rooms").doc(roomId).update({
        'lastMessage': message.text,
        'createdAt': Timestamp.now(),
        'totalUnReadMessages': FieldValue.increment(1),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  Stream<List<MessageModel>> getMessagesForRoom(String roomId) {
    final messageCollection = firestore
        .collection("Rooms")
        .doc(roomId)
        .collection("Messages")
        .orderBy("createdAt", descending: true);

    return messageCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromFirestore(doc.data()))
        .toList());
  }
}
