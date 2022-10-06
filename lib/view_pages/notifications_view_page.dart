import 'package:chat_messenger_app/models/followers_model.dart';
import 'package:flutter/material.dart';

class NotificatonsViewPage extends StatelessWidget {
  const NotificatonsViewPage({Key? key, required this.loadData})
      : super(key: key);
  final Future<List<FollowersModel>> loadData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FollowersModel>? followersList = snapshot.data;
          return ListView.builder(
            itemCount: followersList!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    leading: CircleAvatar(
                      radius: 40,
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(followersList[index].img),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 5),
                            child: RichText(
                              text: TextSpan(
                                text: '${followersList[index].name} ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: followersList[index].notification,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
