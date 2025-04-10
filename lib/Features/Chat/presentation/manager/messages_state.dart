part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}

final class SendMessagesLoading extends MessagesState {}

final class SendMessagesSuccess extends MessagesState {}

final class SendMessagesError extends MessagesState {
  final String message;
  SendMessagesError(this.message);
}

final class MessagesLoading extends MessagesState {}

final class MessagesLoadedSuccess extends MessagesState {
  final List<MessageModel> messages;
  MessagesLoadedSuccess(this.messages);
}

final class MessagesLoadedError extends MessagesState {
  final String errormessage;
  MessagesLoadedError(this.errormessage);
}
