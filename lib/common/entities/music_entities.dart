class RadioConfig {
  int? id;
  String? title;
  String? artist;
  String? artwork;
  String? url;

  RadioConfig({this.id, this.title, this.artist, this.artwork, this.url});

  factory RadioConfig.fromJson(Map<String, dynamic> json) {
    return RadioConfig(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      artwork: json['artwork'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'artwork': artwork,
      'url': url,
    };
  }
}

class ResponseApi<T> {
  int? statusCode;
  String? message;
  T? data;

  ResponseApi({this.statusCode, this.message, this.data});

  factory ResponseApi.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) {
    return ResponseApi<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
