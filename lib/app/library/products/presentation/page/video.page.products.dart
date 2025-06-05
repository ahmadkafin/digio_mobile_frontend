import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPageProducts extends StatelessWidget {
  const VideoPageProducts({
    super.key,
    required this.videoTitle,
    required this.videoId,
  });
  final String? videoTitle;
  final String? videoId;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      autoPlay: true,
      params: YoutubePlayerParams(
        mute: false,
        showControls: false,
        showFullscreenButton: false,
        enableJavaScript: true,
        playsInline: true,
        showVideoAnnotations: false,
        strictRelatedVideos: true,
      ),
    );
    Size deviceSize = MediaQuery.of(context).size;
    return YoutubePlayerScaffold(
      autoFullScreen: true,
      fullscreenOrientations: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
      builder: (context, player) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: true,
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              title: Text(
                videoTitle!,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                height: deviceSize.height,
                padding: const EdgeInsets.only(bottom: 50),
                color: Colors.black,
                child: player,
              ),
            )
          ],
        );
      },
      controller: _controller,
    );
  }
}
