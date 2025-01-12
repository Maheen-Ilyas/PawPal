import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String response = "";
  final gemini = Gemini.instance;
  final TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(
    id: '0',
    firstName: 'User',
  );
  ChatUser medLia = ChatUser(
    id: '1',
    firstName: 'MedLia',
  );

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [
        chatMessage,
        ...messages,
      ];
    });

    try {
      String question = chatMessage.text;

      gemini.promptStream(
        parts: [
          Part.text(question),
        ],
      ).listen((value) {
        setState(() {
          response += value!.output.toString();
          Future.delayed(
            const Duration(seconds: 5),
          );
          ChatMessage responseMessage = ChatMessage(
            user: medLia,
            createdAt: DateTime.now(),
            text: response,
          );
          messages = [responseMessage, ...messages];
          response = "";
        });
      });
    } catch (e) {
      Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const Spacer(),
            Container(
              height: 50.0,
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/paw.png'),
            ),
            const SizedBox(width: 10.0),
            const Text(
              "Chat",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: sendMessage,
        messages: messages,
        inputOptions: const InputOptions(
          cursorStyle: CursorStyle(
            color: Colors.black,
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        messageOptions: const MessageOptions(
          currentUserContainerColor: Color.fromRGBO(169, 118, 184, 1.0),
          showOtherUsersName: true,
        ),
      ),
    );
  }
}
