import 'package:chat_app/constant.dart';

class Message {
  final String message;
  final String id;
  Message({required this.message, required this.id});

  factory Message.fromJeson(jesonData) {
    return Message(message: jesonData[KMessage], id: jesonData['id']);
  }
}
