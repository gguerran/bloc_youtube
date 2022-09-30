import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_you/bloc/favorite_bloc.dart';
import 'package:fav_you/bloc/videos_bloc.dart';
import 'package:fav_you/delegates/search_delegate.dart';
import 'package:fav_you/models/video.dart';
import 'package:fav_you/screens/favorites.dart';
import 'package:fav_you/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideosBloc videosBloc = BlocProvider.getBloc<VideosBloc>();
    final FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Image.asset(
          "assets/images/logo_dark.png",
          height: 25,
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: favoriteBloc.outFav,
              builder: (context, snapshot) => Text(
                snapshot.data!.length.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.star)),
          IconButton(
            onPressed: () async {
              String? result = await showSearch(
                context: context,
                delegate: DataSearch(),
              );

              if (result != null) videosBloc.inSearch.add(result);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<List<Video>>(
        stream: videosBloc.outVideos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
            itemCount: snapshot.data!.length + 1,
            itemBuilder: (context, index) {
              if (index < snapshot.data!.length) {
                return VideoTile(video: snapshot.data![index]);
              }
              videosBloc.inSearch.add(null);
              return Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
