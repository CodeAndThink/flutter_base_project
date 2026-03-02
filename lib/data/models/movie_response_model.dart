import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_response_model.g.dart';

@JsonSerializable()
class MovieResponseModel {
  final List<MovieModel>? results;

  MovieResponseModel({this.results});

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}
