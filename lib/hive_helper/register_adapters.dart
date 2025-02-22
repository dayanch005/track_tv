import 'package:hive/hive.dart';
import 'package:flutter_application_4/model/movie.dart';

void registerAdapters() {
	Hive.registerAdapter(MovieAdapter());
}
