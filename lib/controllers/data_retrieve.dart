import 'dart:convert';

import 'package:chat_messenger_app/models/chat_msg_model.dart';
import 'package:chat_messenger_app/models/followers_model.dart';
import 'package:chat_messenger_app/models/shop_model.dart';
import 'package:chat_messenger_app/models/profile_model.dart';
import 'package:http/http.dart' as http;

class DataRetrieve {
  String url =
      'https://gist.githubusercontent.com/tassiogustavo/43ef3411f0643bcd5c00482705393007/raw/8d418132aab70f7bc65c2623fc4679b977fc6bfd/chat_message_app.json';

  Future<List<ShopModel>> shopDataRetrieve() async {
    http.Response response = await http.get(Uri.parse(url));
    final shopImgs = <ShopModel>[];

    Map map = json.decode(response.body);
    for (int i = 0; i < (map['shopImages'] as List<dynamic>).length; i++) {
      shopImgs.add(ShopModel(map['shopImages'][i]));
    }

    return shopImgs;
  }

  Future<ProfileModel?> profileDataRetrieve() async {
    http.Response response = await http.get(Uri.parse(url));
    ProfileModel? profileInfos;

    Map map = json.decode(response.body);
    List<String> listImgPosts = [];
    for (int i = 0;
        i < (map['profile']["listImgPosts"] as List<dynamic>).length;
        i++) {
      listImgPosts.add(map['profile']["listImgPosts"][i]);
    }

    profileInfos = ProfileModel(
      map['profile']["img"],
      map['profile']["name"],
      map['profile']["description"],
      map['profile']["numPosts"],
      map['profile']["numFollowers"],
      map['profile']["numFollowing"],
      listImgPosts,
    );

    return profileInfos;
  }

  Future<List<FollowersModel>> follwersDataRetrieve() async {
    http.Response response = await http.get(Uri.parse(url));
    final followers = <FollowersModel>[];

    Map map = json.decode(response.body);

    for (int i = 0; i < (map['followers'] as List<dynamic>).length; i++) {
      List<ChatMsgModel> listChat = [];

      for (int j = 0;
          j < (map['followers'][i]["chatMsgs"] as List<dynamic>).length;
          j++) {
        listChat.add(
          ChatMsgModel(
            map['followers'][i]["chatMsgs"][j]["text"],
            map['followers'][i]["chatMsgs"][j]["date"],
            map['followers'][i]["chatMsgs"][j]["isMine"],
          ),
        );
      }
      followers.add(FollowersModel(
        map['followers'][i]["img"],
        map['followers'][i]["name"],
        map['followers'][i]["unreadMsg"],
        map['followers'][i]["lastSeen"],
        map['followers'][i]["notification"],
        listChat,
      ));
    }

    return followers;
  }
}
