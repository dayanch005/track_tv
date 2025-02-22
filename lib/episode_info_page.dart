import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart'; // FlickVideoPlayer import
import 'package:video_player/video_player.dart';
import 'model/movie.dart';

class EpisodeInfoPage extends StatefulWidget {
  final Movie movie;

  const EpisodeInfoPage({super.key, required this.movie});

  @override
  State<EpisodeInfoPage> createState() => _EpisodeInfoPageState();
}

class _EpisodeInfoPageState extends State<EpisodeInfoPage> {
  late FlickManager flickManager; // FlickManager'ini alýarys
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.network(widget.movie.videoUrl);
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController, // Wideo URL-si
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Episode Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FlickVideoPlayer widget'ini ýerleşdiriň
            FlickVideoPlayer(flickManager: flickManager),
            // Başga widgetler, meselem epizod ady we maglumatlar
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Wideo oýnatmak we saklamak işini ýerine ýetirýäris
            if (videoPlayerController.value.isPlaying) {
              videoPlayerController.pause(); // Saklamak
            } else {
              videoPlayerController.play(); // Oýnatmak
            }
          });
        },
        child: Icon(
          videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow, // Oýnatmak we saklamak üçin icon
        ),
      ),
    );
  }
}
