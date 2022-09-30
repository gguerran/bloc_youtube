import 'package:fav_you/models/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final Video video;
  const VideoPlayerScreen({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: video.id,
          ),
          liveUIColor: Colors.red,
          onEnded: (metaData) => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
