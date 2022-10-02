import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  User? loginUser;
  bool getmessage = true;
  late var messageList;
  bool isCurrentUser = false;

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    getUser();
    // getMessageStream();
  }

  void getUser() {
    loginUser = _auth.currentUser;
  }

  void getMessage() async {
    final messages = await _firestore.collection('chat_gp_1').get();

    for (var i in messages.docs) {
      print(">>>>>>>");
      print(i.data()['message']);
    }
  }

  void getMessageStream() async {
    await for (var snapshot in _firestore.collection('chat_gp_1').snapshots()) {
      for (var message in snapshot.docs) {
        print("-------------->");
        print(message.data()['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('chat_gp_1')
                // .orderBy('timestamp', descending: false)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              List<MessageDesign> messageWidget = [];
              if (snapshot.hasData) {
                var messages = snapshot.data!.docs;

                for (var message in messages) {
                  print('>>>>>>>>>');
                  var messageText = message;
                  final sender = messageText['sender'];
                  final text = messageText['message'];
                  final currentUser = loginUser!.email;

                  final msgWidget = MessageDesign(
                    sender: sender,
                    messageText: text,
                    isCurrentUser: isCurrentUser,
                  );
                  messageWidget.add(msgWidget);
                }
              }
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: messageWidget,
                ),
              );
            },
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter a message",
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  try {
                    _firestore.collection('chat_gp_1').add({
                      "sender": loginUser!.email,
                      "message": messageController.text,
                    });
                  } catch (e) {
                    print(">>>>>>");
                    print(e);
                  }
                },
                child: const Icon(Icons.telegram_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageDesign extends StatelessWidget {
  final String sender;
  final String messageText;
  final bool isCurrentUser;
  const MessageDesign(
      {Key? key,
      required this.sender,
      required this.messageText,
      required this.isCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender),
          Material(
              color: isCurrentUser
                  ? Color.fromARGB(255, 125, 236, 46)
                  : Color.fromARGB(255, 65, 141, 223),
              borderRadius: BorderRadius.only( 
                topLeft:
                    isCurrentUser ? Radius.circular(25) : Radius.circular(0),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight:
                    isCurrentUser ? Radius.circular(0) : Radius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(messageText),
              )),
        ],
      ),
    );
  }
}
