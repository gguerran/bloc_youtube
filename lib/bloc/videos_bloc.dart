import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_you/api.dart';
import 'package:fav_you/models/video.dart';

class VideosBloc implements BlocBase {
  Api api = Api();
  List<Video> videoList = [];
  final StreamController<List<Video>> _videosController = StreamController();
  final StreamController<String?> _searchController = StreamController();

  Stream<List<Video>> get outVideos => _videosController.stream;
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    _searchController.stream.listen(_search);
  }

  void _search(String? search) async {
    videoList = search != null
        ? await api.search(search: search)
        : videoList += await api.nextPage();
    search != null
        ? _videosController.sink.add([])
        : _videosController.sink.add(videoList);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
