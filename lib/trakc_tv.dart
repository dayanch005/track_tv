import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/movies_data.dart';
import 'episode_info_page.dart';
import 'home_page.dart';
import 'photo_page.dart';
import 'provider/favorite_provider.dart';
import 'settings_page.dart';

class TrackTV extends StatefulWidget {
  const TrackTV({super.key});

  @override
  State<TrackTV> createState() => _TrackTVState();
}

class _TrackTVState extends State<TrackTV> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    FavouritesPage(),
    PhotoPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    Provider.of<FavoriteProvider>(context, listen: false).getHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 100;
    double screenHeight = MediaQuery.of(context).size.height / 100;
    double fontSize = screenWidth < 600 ? 18 : 22;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TrackTV",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: fontSize,
          ),
        ),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(child: Text("Boat")),
              const PopupMenuItem(
                child: Text("Train"),
              )
            ];
          }),
        ],
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie.imageUrl,
                          width: screenWidth * 24,
                          height: screenHeight * 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth < 600 ? 18 : 22,
                            ),
                          ),
                          Text(
                            movie.names,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            movie.type, // Kino ýa-da serialdygyny görkezýär
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          if (movie.type ==
                              'Serial') // Serial bolsa epizod sanyny görkezýär
                            Text(
                              'Epizod sany: ${movie.numberOfEpisodes}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          Row(children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EpisodeInfoPage(movie: movie),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(200, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: screenWidth * 0.66,
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                width: screenWidth * 30,
                                height: screenHeight * 4,
                                child: const Center(
                                  child: Text(
                                    "Episode info",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "   7 left",
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 10),
                            ),
                            Consumer<FavoriteProvider>(
                              builder: (context, favoriteProvider, _) {
                                final isFavorited =
                                    favoriteProvider.isFavourite(movie);

                                return IconButton(
                                  icon: Icon(
                                    isFavorited
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorited ? Colors.red : Colors.black,
                                  ),
                                  onPressed: () {
                                    // Kinony halanlardan aýyrmak ýa-da goşmak
                                    if (isFavorited) {
                                      favoriteProvider
                                          .removeFromFavourites(movie);
                                    } else {
                                      favoriteProvider.addToFavourites(movie);
                                    }
                                  },
                                );
                              },
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : _selectedIndex == 1
              ? FavouritesPage()
              : _selectedIndex == 2
                  ? PhotoPage() // "Gosmak" sahypasy üçin PhotoPage
                  : SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: const Color.fromARGB(255, 22, 20, 20),
        iconSize: MediaQuery.of(context).size.width < 600 ? 20 : 30,
        selectedItemColor: Colors.amber,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 207, 137, 17),
              size: 30,
            ),
            label: 'Öý',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 199, 43, 31),
              size: 35,
            ),
            label: 'Halanlarym',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.blue,
                size: 35,
              ),
              label: "Gosmak"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Color.fromARGB(255, 183, 186, 189),
              size: 30,
            ),
            label: 'Sazlamalar',
          ),
        ],
      ),
    );
  }
}

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 100;
    double screenHeight = MediaQuery.of(context).size.height / 100;
    double fontSize = screenWidth < 600 ? 18 : 22;
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favouriteMovies = favoriteProvider.favouriteMovies;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halanlarym'),
        backgroundColor: Colors.amber,
      ),
      body: favouriteMovies.isEmpty
          ? const Center(child: Text('Halanlaryňyz ýok'))
          : ListView.builder(
              itemCount: favouriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favouriteMovies[index];
                return ListTile(
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie.imageUrl,
                          width: screenWidth * 30,
                          height: screenHeight * 17,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: screenWidth * 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            movie.names,
                            style: const TextStyle(fontSize: 13),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              favoriteProvider.removeFromFavourites(movie);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
