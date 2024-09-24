import 'package:bloc/bloc.dart';
import 'package:chat_app/core/constant.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);

  sendMessage({required message, required email}) {
    try {
      messages
          .add({'massege': message, 'createdAt': DateTime.now(), 'id': email});
    } on Exception catch (e) {
      // TODO
    }
  }

  getMessages() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen(
      (onData) {
        List<Message> messagesList = [];
        for (var doc in onData.docs) {
          messagesList.add(Message.fromJeson(doc));
        }
        emit(ChatSuccess(messages: messagesList));
      },
    );
  }
}
