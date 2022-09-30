import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_you/bloc/favorite_bloc.dart';
import 'package:fav_you/bloc/videos_bloc.dart';
import 'package:fav_you/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        blocs: [
          Bloc((i) => VideosBloc()),
          Bloc((i) => FavoriteBloc()),
        ],
        dependencies: const [],
        child: MaterialApp(
          themeMode: ThemeMode.dark,
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const Home(),
        ),
      );
}
