import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  const VideoScreen({super.key, required this.videoUrl});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          controller.play();
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text("Reels"),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
 
          Center(
            child: controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            )
                : const Center(
              child: CupertinoActivityIndicator(color: Colors.pinkAccent),
            ),
          ),

          Positioned(
            right: 16,
            bottom: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: const [
                    Icon(Icons.favorite, color: Colors.red, size: 32),
                    SizedBox(height: 4),
                    Text("120", style: TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: const [
                    Icon(Icons.comment, color: Colors.white, size: 32),
                    SizedBox(height: 4),
                    Text("45", style: TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: const [
                    Icon(Icons.bookmark, color: Colors.white, size: 32),
                    SizedBox(height: 4),
                    Text("30", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
    Positioned(
            left: 16,
            bottom: 70,
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            CircleAvatar(
            radius: 24,
            backgroundImage:NetworkImage("https://picsum.photos/200/300"), 
            ),
            const SizedBox(width: 10),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            "@username",
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            ),
            ),
            const SizedBox(height: 4),
            Text(
            "This is the video caption goes here...",
            style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            ),
            ),
            ],
    )
    ]
    )
    )
        ],
      ),
    );
  }
}


