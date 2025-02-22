import 'package:flutter_application_4/data/movies_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'model/movie.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _episodesController = TextEditingController();

  // Bu funksiýa "foto" goşmak üçin işledi we dogry ýagdaýda kinony goşar.
  void _addMovie() {
    final name = _nameController.text;
    final url = _urlController.text;
    final type = _typeController.text;
    final info = _infoController.text;
    final episodes = int.tryParse(_episodesController.text) ?? 0;

    if (name.isNotEmpty && url.isNotEmpty && type.isNotEmpty) {
      // Bu ýerde filmleri ýa-da seriallary goşup bilersiňiz
      final newMovie = Movie(
        name: name,
        imageUrl: url,
        type: type,
        information: info,
        numberOfEpisodes: episodes,
        videoUrl: "", // Surat üçin video URL goşup bilersiňiz
        names: name, // Suratyň adyny hasaba alýarlar
      );
      setState(() {
        movies.add(newMovie); // Filmi sanawa goş
      });
      // Suraty goşandan soň, täze filmleri sanawda görkezmek üçin kod goşulyp biler.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Film ýa-da surat goşuldy!')),
      );
      // Gözden geçirme prosesi
      Navigator.pop(context); // Formany ýapmak
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gosmak'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Film ýa-da Surat Goşuň",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // Film ýa-da serial adyny goşmak üçin
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Ady'),
            ),
            const SizedBox(height: 5),
            // Surat URL-ini goşmak üçin
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Surat URL'),
            ),
            const SizedBox(height: 5),
            // Türini (kino ýa-da serial) saýlamak üçin
            TextField(
              controller: _typeController,
              decoration:
                  const InputDecoration(labelText: 'Türi (Kino/Serial)'),
            ),
            const SizedBox(height: 5),
            // Düşündiriş goşmak üçin
            TextField(
              controller: _infoController,
              decoration: const InputDecoration(labelText: 'Düşündiriş'),
            ),
            const SizedBox(height: 5),
            // Epizod sanyny (serial üçin) goşmak üçin
            TextField(
              controller: _episodesController,
              decoration:
                  const InputDecoration(labelText: 'Epizod sany (serial üçin)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addMovie,
              child: const Text('Goşmak'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Button reňki
              ),
            ),
            // Sanawyňyzy görkezmek üçin ListView.builder
            const SizedBox(height: 10),
            const Text(
              'Goşulan Kinolar we Suratlar:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ListView.builder kinolar/seriallar sanawyny görkezýär
            Expanded(
              child: ListView.builder(
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
                            width: 105.0,
                            height: 143,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              movie.type, // Kino ýa-da serialdygyny görkezýär
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
