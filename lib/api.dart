import 'dart:convert';

import 'package:fav_you/models/video.dart';
import 'package:http/http.dart' as http;

const String apiKey = "AIzaSyCQP6AECzb5a760jqz7cHn6X4FhcEPIAOc";

class Api {
  String _search = "";
  String _nextToken = "";
  Future<List<Video>> search({required String search}) async {
    _search = search;
    http.Response response = await http.get(
      Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=10",
      ),
    );
    return decode(response: response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
      Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10&pageToken=$_nextToken",
      ),
    );
    return decode(response: response);
  }

  Future<List> suggestions({required String search}) async {
    http.Response response = await http.get(
      Uri.parse(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json",
      ),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[1].map((item) => item[0]).toList();
    } else {
      throw Exception("Failed to load suggestions");
    }
  }

  List<Video> decode({required http.Response response}) {
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      _nextToken = decoded["nextPageToken"];
      return decoded["items"]
          .map<Video>((item) => Video.fromJson(json: item))
          .toList();
    } else {
      throw Exception("Failed to load videos");
    }
  }
}
