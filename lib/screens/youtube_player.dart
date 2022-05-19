import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AlAmmariYoutubePlayer extends StatefulWidget {
  final dynamic video;

  AlAmmariYoutubePlayer({Key? key, required this.video}) : super(key: key);

  @override
  State<AlAmmariYoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<AlAmmariYoutubePlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  bool _muted = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  double videoHeightRatio = 0.3;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.file.split("?v=")[1],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * videoHeightRatio,
      child: YoutubePlayerBuilder(
        // onEnterFullScreen: () {
        //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        //   setState(() {
        //     videoHeightRatio = 0.7;
        //   });
        //   SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
        // },
        onExitFullScreen: () {
          setState(() {
            videoHeightRatio = 0.3;
          });
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16/9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: Icon(_muted ? Icons.volume_off : Icons.volume_up,color: Colors.white,),
              onPressed: _isPlayerReady
                  ? () {
                _muted
                    ? _controller.unMute()
                    : _controller.mute();
                setState(() {
                  _muted = !_muted;
                });
              }
                  : null,
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
        ),
        builder: (context, player) => Scaffold(body: player),
      ),
    );
  }
}
