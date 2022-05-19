import 'dart:async';

import 'package:al_ammari/Models/media_model.dart';
import 'package:flutter/material.dart';
import '../Widget/gradient_icon.dart';
import '../services/repository.dart';
import '../util/style_constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../Models/media_model.dart';

class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  String playingFileValue = "";
  bool playClicked = false;

  List<Media>? audioList;
  List<Media>? categoryAudioList;

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;
  late int playDuration;
  int duration = 5000;

  String dropdownvalue = 'اختر الفئة';

  // List of items in our dropdown menu
  var items = [
    'اختر الفئة',
    'مكة',
    'مدينة',
  ];

  @override
  void initState() {
    getAudioDetails();
    super.initState();
    if (!_mPlayerIsInited) {
      init().then((value) {
        setState(() {
          _mPlayerIsInited = true;
        });
      });
    }
  }

  Future<void> init() async {
    await _mPlayer!.openAudioSession();
    await _mPlayer!.setSubscriptionDuration(const Duration(milliseconds: 50));
    _mPlayerSubscription = _mPlayer!.onProgress!.listen((e) {
      duration = e.duration.inMilliseconds;
      setState(() {
        setPos(e.position.inMilliseconds);
      });
    });
  }

  @override
  void dispose() {
    stopPlayer();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mPlayer!.closeAudioSession();
    _mPlayer = null;
    cancelPlayerSubscriptions();
    super.dispose();
  }

  void cancelPlayerSubscriptions() {
    if (_mPlayerSubscription != null) {
      _mPlayerSubscription!.cancel();
      _mPlayerSubscription = null;
    }
  }

  // -------  Here is the code to playback a remote file -----------------------

  void play(file) async {
    setState(() {
      playClicked = true;
      playingFileValue = file;
    });
    await _mPlayer!.startPlayer(
        fromURI: playingFileValue,
        codec: Codec.mp3,
        whenFinished: () {
          setState(() {
            pos = 0;
            setPos(pos);
          });
        });
    setState(() {
      playClicked = false;
    });
  }

  void pause() async {
    await _mPlayer!.pausePlayer();
    setState(() {});
  }

  void resume() async {
    await _mPlayer!.resumePlayer();
    setState(() {});
  }

  Future<void> stopPlayer() async {
    if (_mPlayer != null) {
      await _mPlayer!.stopPlayer();
    }
    setState(() {
      pos = 0;
      setPos(pos);
    });
  }

  Future<void> seek(double d, audioFile) async {
    if (audioFile == playingFileValue) {
      await _mPlayer?.seekToPlayer(Duration(milliseconds: d.floor()));
      await setPos(d.floor());
    }
  }

  Future<void> setPos(int d) async {
    if (d > duration) {
      d = duration;
    }
    setState(() {
      pos = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: GradientIcon(Icons.arrow_back_ios, 25.0),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: primaryColor,
          elevation: 4,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientIcon(Icons.audiotrack, 30.0),
              Text(
                'صوتي',
                style: TextStyle(
                    fontSize: 20.0,
                    foreground: Paint()..shader = linearGradient),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: GradientIcon(Icons.keyboard_arrow_down, 25.0),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                          fontSize: 20.0,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  changeAudioList(newValue);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.78,
              child: categoryAudioList == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: categoryAudioList!.length,
                      itemBuilder: (context, index) {
                        var audio = categoryAudioList!.elementAt(index);
                        return Card(
                          shadowColor: secondaryColor,
                          color: primaryColor,
                          elevation: 5,
                          child: ListTile(
                            title: Text(
                              audio.title!,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  foreground: Paint()..shader = linearGradient),
                            ),
                            trailing: SizedBox(
                                width: MediaQuery.of(context).size.width * .6,
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (playClicked &&
                                          audio.file == playingFileValue)
                                        const CircularProgressIndicator()
                                      else
                                        IconButton(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {
                                              getPlayBackFn(audio.file);
                                            },
                                            icon: Icon(_mPlayer!.isPlaying &&
                                                    audio.file ==
                                                        playingFileValue
                                                ? Icons.pause
                                                : Icons.play_arrow)),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        child: Slider(
                                          value: (audio.file == playingFileValue
                                                  ? pos
                                                  : 0) +
                                              0.0,
                                          min: 0.0,
                                          max: duration + 0.0,
                                          thumbColor: Color(0xffD0BD86),
                                          onChanged: (value) {
                                            seek(value, audio.file);
                                          },
                                          //divisions: 100
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            stopPlayer().then(
                                                (value) => setState(() {}));
                                          },
                                          icon: const Icon(Icons.stop)),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
              // : Column(children: createAudioPlayers()),
            )
          ],
        ),
      ),
    );
  }

  getAudioDetails() async {
    MediaModel? res = await Repository().fetchAudio();
    if (res!.status!) {
      setState(() {
        audioList = res.media;
        categoryAudioList = audioList;
      });
    }
  }

  changeAudioList(value) {
    setState(() {
      dropdownvalue = value;
      if (audioList != null && dropdownvalue != 'اختر الفئة') {
        categoryAudioList = audioList!
            .where((x) => x.category!.contains(dropdownvalue))
            .toList();
      } else {
        categoryAudioList = audioList;
      }
    });
  }

  getPlayBackFn(audioFile) {
    if (audioFile != playingFileValue) {
      stopPlayer().then((value) => play(audioFile));
    }
    _mPlayer!.isStopped
        ? play(audioFile)
        : (_mPlayer!.isPlaying && audioFile == playingFileValue
            ? pause()
            : resume());
  }
}
