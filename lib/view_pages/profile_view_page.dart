import 'package:chat_messenger_app/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({Key? key, required this.loadData}) : super(key: key);
  final Future<ProfileModel?> loadData;

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          buildProfileInformations(width),
          const SizedBox(height: 35),
          buildCounterFollowers(),
          const SizedBox(height: 25),
          buildButtonsMsgFollow(),
          const SizedBox(height: 15),
          buildGridImagesProfile(),
        ],
      ),
    );
  }

  Padding buildGridImagesProfile() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                future: widget.loadData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                      "Carregando...",
                    ));
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                        image: snapshot.data!.listImgPosts[index],
                      ),
                    );
                  }
                },
              ));
        },
      ),
    );
  }

  Column buildProfileInformations(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: widget.loadData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircleAvatar(
                radius: 65,
                backgroundColor: Colors.black12,
              );
            } else {
              return CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(snapshot.data!.img),
              );
            }
          },
        ),
        const SizedBox(
          height: 30,
        ),
        FutureBuilder(
          future: widget.loadData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text(
                '...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              );
            } else {
              ProfileModel? pm = snapshot.data;
              return Text(
                pm!.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              );
            }
          },
        ),
        const SizedBox(
          height: 3,
        ),
        FutureBuilder(
          future: widget.loadData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text(
                '...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              );
            } else {
              ProfileModel? pm = snapshot.data;
              return Text(
                pm!.description,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: width * 0.55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildMedals(
                  const Color.fromARGB(30, 250, 50, 50), Colors.red, 'N1'),
              buildMedals(
                  const Color.fromARGB(30, 50, 50, 250), Colors.blue, 'B4'),
              buildMedals(
                  const Color.fromARGB(30, 250, 50, 50), Colors.red, 'S2'),
              buildMedals(
                  const Color.fromARGB(30, 50, 50, 250), Colors.blue, 'G5'),
            ],
          ),
        )
      ],
    );
  }

  Container buildMedals(
      Color colorMedal, Color colorTextMedal, String nameMedal) {
    return Container(
      height: 47,
      width: 47,
      decoration: BoxDecoration(
        color: colorMedal,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Center(
        child: Text(
          nameMedal,
          style: TextStyle(
              fontSize: 17, color: colorTextMedal, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding buildButtonsMsgFollow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'Message',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  'Follow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildCounterFollowers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: widget.loadData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      '-',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    );
                  } else {
                    ProfileModel? pm = snapshot.data;
                    return Text(
                      pm!.numPosts.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    );
                  }
                },
              ),
              const Text(
                'Posts',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: widget.loadData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      '-',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    );
                  } else {
                    ProfileModel? pm = snapshot.data;
                    return Text(
                      pm!.numFollowers.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    );
                  }
                },
              ),
              const Text(
                'Followers',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: widget.loadData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      '-',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    );
                  } else {
                    ProfileModel? pm = snapshot.data;
                    return Text(
                      pm!.numFollowing.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    );
                  }
                },
              ),
              const Text(
                'Following',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
