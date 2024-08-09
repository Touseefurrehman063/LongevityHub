import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

ChatUser user = ChatUser(
  id: '1',
  firstName: 'Test ',
  lastName: 'User',
);

List<ChatMessage> messages = <ChatMessage>[
  ChatMessage(
    text: 'Hello Test',
    user: user,
    createdAt: DateTime.now(),
  ),
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  get backgroundcolor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            )),
        title: Image.asset(
          "assets/images/chatappbar.png",
          height: Get.height * 0.07,
          width: Get.width * 0.45,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.fill,
          ),
        ),
        child: DashChat(
          scrollToBottomOptions: const ScrollToBottomOptions(),
          currentUser: user,
          onSend: (ChatMessage m) {
            setState(() {
              messages.insert(0, m);
            });
          },
          inputOptions: InputOptions(
            inputDecoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.25),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Write your message",
                hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
            alwaysShowSend: true,
            cursorStyle: const CursorStyle(color: Colors.black),
          ),
          messages: messages,
        ),
      ),
    );
  }
}
