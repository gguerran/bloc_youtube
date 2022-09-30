class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
  });

  factory Video.fromJson({required Map<String, dynamic> json}) =>
      json.containsKey("id")
          ? Video(
              id: json["id"]["videoId"],
              title: json["snippet"]["title"],
              thumb: json["snippet"]["thumbnails"]["high"]["url"],
              channel: json["snippet"]["channelTitle"],
            )
          : Video(
              id: json["videoId"],
              title: json["title"],
              thumb: json["thumb"],
              channel: json["channel"],
            );

  Map<String, String> toJson() =>
      {"videoId": id, "title": title, "thumb": thumb, "channel": channel};
}
