// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_cast

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num?)?.toInt(),
  titleLocal: MovieModel._readTitle(json, 'title') as String?,
  overview: json['overview'] as String?,
  posterPathLocal: json['poster_path'] as String?,
  backdropPathLocal: json['backdrop_path'] as String?,
  voteAverageLocal: (json['vote_average'] as num?)?.toDouble(),
  releaseDateLocal: json['release_date'] as String?,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'overview': instance.overview,
      'poster_path': instance.posterPathLocal,
      'backdrop_path': instance.backdropPathLocal,
      'vote_average': instance.voteAverageLocal,
      'release_date': instance.releaseDateLocal,
      'title': instance.titleLocal,
    };
