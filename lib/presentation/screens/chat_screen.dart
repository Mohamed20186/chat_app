import 'package:chat_app/core/constant.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:chat_app/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static String id = 'chatScreen';
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    var chatProvider = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 70,
        title: SizedBox(
          height: 50,
          width: 190,
          child: Image.asset(
              'assets/images/chatchirp-high-resolution-logo-transparent.png'),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: ((context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(
                            message: messagesList[index],
                          )
                        : ChatBubbleForFriend(
                            message: messagesList[index],
                          );
                  }),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                chatProvider.sendMessage(message: data, email: email);

                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(microseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              },
              style: GoogleFonts.aldrich(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'send Message...',
                suffixIcon: Icon(Icons.send),
                suffixIconColor: kPrimaryColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: KThirdcolor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kSecondlyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
