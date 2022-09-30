import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_you/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};
  final _favController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then(
      (prefs) {
        if (prefs.getKeys().contains("favorites")) {
          _favorites =
              jsonDecode(prefs.getString("favorites") ?? "").map<String, Video>(
            (key, value) => MapEntry<String, Video>(
              key,
              Video.fromJson(json: value),
            ),
          );
          _favController.add(_favorites);
        }
      },
    );
  }

  void toggleFavorite(Video video) {
    _favorites.containsKey(video.id)
        ? _favorites.remove(video.id)
        : _favorites[video.id] = video;
    _favController.sink.add(_favorites);
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setString("favorites", jsonEncode(_favorites)),
    );
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
