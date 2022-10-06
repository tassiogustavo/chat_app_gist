import 'package:chat_messenger_app/models/followers_model.dart';
import 'package:chat_messenger_app/screens/call_screen.dart';
import 'package:flutter/material.dart';

class PrivateChat extends StatefulWidget {
  const PrivateChat({Key? key, required this.follower}) : super(key: key);
  final FollowersModel follower;

  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          buildListChatMessages(),
          buildWriteMessageBottomBar(),
        ],
      ),
    );
  }

  Expanded buildListChatMessages() {
    return Expanded(
        child: ListView.builder(
      itemCount: widget.follower.chatMsgs.length,
      reverse: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: widget.follower.chatMsgs[index].isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
                decoration: BoxDecoration(
                  color: widget.follower.chatMsgs[index].isMine
                      ? Colors.blueAccent
                      : const Color.fromARGB(225, 220, 220, 220),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: widget.follower.chatMsgs[index].isMine
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          widget.follower.chatMsgs.reversed
                              .toList()[index]
                              .text,
                          style: TextStyle(
                              color: widget.follower.chatMsgs[index].isMine
                                  ? Colors.white
                                  : Colors.black87),
                        ),
                      ),
                      Text(
                        widget.follower.chatMsgs[index].date,
                        style: TextStyle(
                            color: widget.follower.chatMsgs[index].isMine
                                ? Colors.white70
                                : Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget buildWriteMessageBottomBar() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.black87,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 3, left: 15),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'Message',
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.mic,
                    color: Colors.black87,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.send,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      title: ListTile(
        contentPadding: const EdgeInsets.only(left: 0.0),
        leading: CircleAvatar(
          radius: 25,
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(widget.follower.img),
        ),
        title: Text(
          widget.follower.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.follower.lastSeen,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.videocam_rounded,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    follower: widget.follower,
                    iconData: Icons.videocam_off_outlined,
                  ),
                ));
          },
        ),
        IconButton(
            icon: const Icon(
              Icons.call,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CallScreen(
                      follower: widget.follower,
                      iconData: Icons.call_end,
                    ),
                  ));
            }),
      ],
    );
  }
}
