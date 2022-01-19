import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  static const String kAlbumIdJsonKey = 'albumId';
  static const String kIdJsonKey = 'id';
  static const String kTitleJsonKey = 'title';
  static const String kUrlJsonKey = 'url';
  static const String kThumbnailUrlJsonKey = 'thumbnailUrl';

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  @override
  List<Object> get props => [albumId, id, title, url, thumbnailUrl];

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json[kAlbumIdJsonKey].toInt(),
      id: json[kIdJsonKey].toInt(),
      title: json[kTitleJsonKey].toString(),
      url: json[kUrlJsonKey].toString(),
      thumbnailUrl: json[kThumbnailUrlJsonKey].toString(),
    );
  }

  Photo copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) {
    return Photo(
      albumId: albumId ?? this.albumId,
      id: id ?? this.albumId,
      title: title ?? this.title,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
