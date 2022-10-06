import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_messenger_app/models/followers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key, required this.follower, required this.iconData})
      : super(key: key);
  final FollowersModel follower;
  final IconData iconData;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  bool isFull = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Image.network(
              widget.follower.img,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Center(
            child: SizedBox(
              height: height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarGlow(
                    animate: true,
                    glowColor: Colors.white,
                    endRadius: 75,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 10),
                    repeat: true,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        widget.follower.img,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.follower.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Text(
                    'calling.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.manual,
                        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
                      );

                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.redAccent,
                    elevation: 0,
                    child: Icon(
                      widget.iconData,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
