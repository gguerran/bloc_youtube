import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_you/bloc/favorite_bloc.dart';
import 'package:fav_you/models/video.dart';
import 'package:fav_you/screens/video_player.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  const VideoTile({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(video: video),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(video.thumb, fit: BoxFit.cover),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.channel,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: favoriteBloc.outFav,
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              favoriteBloc.toggleFavorite(video);
                            },
                            icon: Icon(
                              snapshot.data!.containsKey(video.id)
                                  ? Icons.star
                                  : Icons.star_border,
                            ),
                            iconSize: 30,
                          );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
