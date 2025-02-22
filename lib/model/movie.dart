import 'package:hive/hive.dart';
import 'package:flutter_application_4/hive_helper/hive_types.dart';
import 'package:flutter_application_4/hive_helper/hive_adapters.dart';
import 'package:flutter_application_4/hive_helper/fields/movie_fields.dart';

part 'movie.g.dart';


@HiveType(typeId: HiveTypes.movie, adapterName: HiveAdapters.movie)
class Movie extends HiveObject{
	@HiveField(MovieFields.names)
  final String names;
	@HiveField(MovieFields.name)
  final String name;
	@HiveField(MovieFields.imageUrl)
  final String imageUrl;
	@HiveField(MovieFields.information)
  final String information;
	@HiveField(MovieFields.type)
  final String type;
	@HiveField(MovieFields.numberOfEpisodes)
  final int numberOfEpisodes;
	@HiveField(MovieFields.videoUrl)
  final String videoUrl;

  Movie({
    required this.name,
    required this.names,
    required this.information,
    required this.imageUrl,
    required this.type,
    this.numberOfEpisodes = 0,
    required this.videoUrl,
  });
}