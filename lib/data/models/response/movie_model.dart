import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_base_project/data/models/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Movie {
  @JsonKey(name: 'poster_path')
  final String? posterPathLocal;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPathLocal;
  @JsonKey(name: 'vote_average')
  final double? voteAverageLocal;
  @JsonKey(name: 'release_date')
  final String? releaseDateLocal;
  @JsonKey(name: 'title', readValue: _readTitle)
  final String? titleLocal;

  const MovieModel({
    super.id,
    this.titleLocal,
    super.overview,
    this.posterPathLocal,
    this.backdropPathLocal,
    this.voteAverageLocal,
    this.releaseDateLocal,
  }) : super(
         title: titleLocal,
         posterPath: posterPathLocal,
         backdropPath: backdropPathLocal,
         voteAverage: voteAverageLocal,
         releaseDate: releaseDateLocal,
       );

  static String? _readTitle(Map json, String key) {
    return json['title'] as String? ?? json['name'] as String?;
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
