import 'package:chat_messenger_app/models/chat_msg_model.dart';
import 'package:chat_messenger_app/models/followers_model.dart';
import 'package:chat_messenger_app/screens/private_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ChatViewPage extends StatelessWidget {
  const ChatViewPage({Key? key, required this.loadData}) : super(key: key);
  final Future<List<FollowersModel>> loadData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStory(),
          buildTextChats(),
          buildChatList(),
        ],
      ),
    );
  }

  Widget buildChatList() {
    return FutureBuilder(
      future: loadData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FollowersModel>? followersList = snapshot.data;
          return ListView.builder(
            itemCount: followersList!.length,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PrivateChat(follower: followersList[index]),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      leading: CircleAvatar(
                        radius: 40,
                        foregroundColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(followersList[index].img),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            followersList[index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          followersList[index].unreadMsg == 0
                              ? Container()
                              : Container(
                                  width: 17,
                                  height: 17,
                                  decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      followersList[index].unreadMsg.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getLastTextChat(followersList[index]),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              followersList[index].chatMsgs.last.date,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: const [
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.insert_drive_file_outlined,
                  size: 40,
                ),
                Text(
                  'no data received',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: const [
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(),
                Text(
                  'Awaiting result...',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  String getLastTextChat(FollowersModel followersList) {
    List<ChatMsgModel> chat = followersList.chatMsgs;
    return chat.last.text.toString();
  }

  Widget buildStory() {
    return FutureBuilder(
      future: loadData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          List<FollowersModel>? listFollower = snapshot.data;
          return Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: listFollower!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index != 0
                              ? Colors.lightBlue
                              : const Color.fromARGB(225, 220, 220, 220),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 63,
                        width: 63,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(225, 220, 220, 220),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: index != 0
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  fit: BoxFit.cover,
                                  image: listFollower[index].img,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black54,
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Padding buildTextChats() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
        bottom: 10,
      ),
      child: Text(
        'Chats',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
