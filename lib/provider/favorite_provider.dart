import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/movie.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Movie> favorite = [];

  List<Movie> get favouriteMovies => favorite;

  void getHive() {
    var box = Hive.box('moviesBox');
    // box.clear();
    print("object  ${box.values.length}");
    List<dynamic> bazadan = box.get("product", defaultValue: []);
    print("bazadan ${bazadan.length}");
    if (bazadan.isNotEmpty) {
      favorite =
          List<Movie>.from(bazadan.map((toElement) => toElement as Movie));
    }
  }

  void addToFavourites(Movie movie) {
    favorite.add(movie); // Kinony box-a goşmak
    Hive.box("moviesBox").put("product", favorite);
    notifyListeners(); // UI-ni täzeden täzelenme üçin bildiriň
  }

  void removeFromFavourites(Movie movie) {
    final index = favorite.toList().indexOf(movie);
    if (index != -1) {
      favorite.removeAt(index); // Kinony box-dan aýyrmak
      Hive.box("moviesBox").put("product", favorite);
      notifyListeners(); // UI-ni täzeden täzelenme üçin bildiriň
    }
  }

  bool isFavourite(Movie movie) {
    for (var i = 0; i < favorite.length; i++) {
      if (favorite[i].name == movie.name) {
        return true;
      }
    }

    return false;
  }
}
