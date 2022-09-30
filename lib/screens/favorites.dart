import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_you/bloc/favorite_bloc.dart';
import 'package:fav_you/models/video.dart';
import 'package:fav_you/screens/video_player.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: favoriteBloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.hasData
                ? snapshot.data!.values
                    .map(
                      (Video video) => InkWell(
                        onLongPress: () {
                          favoriteBloc.toggleFavorite(video);
                        },
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayerScreen(video: video),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: Image.network(video.thumb),
                            ),
                            Expanded(
                                child: Text(
                              video.title,
                              style: const TextStyle(color: Colors.white70),
                              maxLines: 2,
                            ))
                          ],
                        ),
                      ),
                    )
                    .toList()
                : [],
          );
        },
      ),
    );
  }
}
