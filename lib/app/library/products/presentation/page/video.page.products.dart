import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/core/utils/styleText.utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPageProducts extends StatefulWidget {
  const VideoPageProducts({
    super.key,
    required this.videoTitle,
    required this.videoId,
  });

  final String? videoTitle;
  final String? videoId;

  @override
  State<VideoPageProducts> createState() => _VideoPageProductsState();
}

class _VideoPageProductsState extends State<VideoPageProducts> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Lock to landscape on entry
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId!,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableJavaScript: true,
        playsInline: true,
      ),
    );

    // Auto fullscreen after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.enterFullScreen();
    });
  }

  @override
  void dispose() {
    // Restore to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      autoFullScreen: false, // prevent scaffold from overriding our fullscreen
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                _controller.exitFullScreen();
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              widget.videoTitle ?? '',
              style: TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(child: player),
        );
      },
    );
  }
}
