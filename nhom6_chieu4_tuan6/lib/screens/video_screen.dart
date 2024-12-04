import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  const VideoScreen({super.key, required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController? _videoController; // For local videos
  late YoutubePlayerController? _youtubeController; // For YouTube videos
  bool isYouTube = false;

  @override
  void initState() {
    super.initState();

    // Kiểm tra xem video là YouTube hay cục bộ
    if (widget.videoUrl.contains('youtube.com') || widget.videoUrl.contains('youtu.be')) {
      isYouTube = true;
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      isYouTube = false;
      _videoController = VideoPlayerController.asset(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
    }
  }

  @override
  void dispose() {
    if (isYouTube) {
      _youtubeController?.dispose();
    } else {
      _videoController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Center(
        child: isYouTube
            ? YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          onReady: () {
            debugPrint('YouTube Player is ready.');
          },
        )
            : (_videoController != null && _videoController!.value.isInitialized)
            ? AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: isYouTube
          ? null
          : FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoController!.value.isPlaying) {
              _videoController!.pause();
            } else {
              _videoController!.play();
            }
          });
        },
        child: Icon(
          _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
