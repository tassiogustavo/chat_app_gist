import 'package:chat_messenger_app/models/chat_msg_model.dart';

class FollowersModel {
  String img;
  String name;
  int unreadMsg;
  String lastSeen;
  String notification;
  List<ChatMsgModel> chatMsgs;

  FollowersModel(
    this.img,
    this.name,
    this.unreadMsg,
    this.lastSeen,
    this.notification,
    this.chatMsgs,
  );
}
