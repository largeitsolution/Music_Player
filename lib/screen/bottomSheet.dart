import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:music_player_final/gobalVarialbe/gobalVariable.dart';

class BottomSheet1 extends StatefulWidget {
  BottomSheet1({this.alldata});
  var alldata;
  @override
  State<BottomSheet1> createState() => _BottomSheet1State();
}

class _BottomSheet1State extends State<BottomSheet1> {
  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
            print(audioDuration.toDouble());
            print(value);
            if (value == audioDuration.toDouble()) {
              indexloop++;
              setState(() {
                alldata = musicList[indexloop];
              });
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    playautonextsong();
    dataList.add(alldata);
    print(dataList);

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        audioPlayerState = state;
        print(audioPlayerState);
      });
      if (PlayerState.COMPLETED == audioPlayerState) {
        indexloop++;
        setState(() {
          playMusic();
        });
        alldata = musicList[indexloop];
        playMusic();
        setState(() {});
      }
    });

    /// Optional
    audioPlayer.play(showdata
        ? alldata['url']
        : null); // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });
  }

  /// Compulsory
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.onSeekComplete;
    audioPlayerState.index;
    // audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(showdata ? alldata['url'] : null);
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  /// Optional
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer
        .seek(newPos); // Jumps to the given position within the audio file
  }

  /// Optional
  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  onselectedIndex(int index) {
    setState(() {
      seletedindex = index;
    });
  }

  playautonextsong() {
    audioPlayer.onPlayerCompletion.listen((event) {
      if (audioPlayerState == PlayerState.PLAYING) {
        setState(() {
          indexloop++;
          seletedindex++;
          // alldata = musicList[indexloop];
          playMusic();
        });
      } else {
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Play as your mood'),
          toolbarHeight: 80,
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          // height: 660,
          child: Column(
            children: [
              Container(
                height: 300,
                color: Colors.pink,
                child: Column(
                  children: [
                    Container(
                        height: 300,
                        child: Image.network(
                          alldata['image'],
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image.network(alldata['image']),
                  title: Text(alldata['title']),
                  subtitle: Text(alldata['singer']),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getTimeString(timeProgress)),
                  SizedBox(width: 20),
                  Container(width: 200, child: slider()),
                  SizedBox(width: 20),
                  Text(getTimeString(audioDuration - timeProgress)),
                  // nextSongAutomatic(p:timeProgress, a:audioDuration),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.repeat),
                      iconSize: 30.0,
                      onPressed: () {
                        if (isLoop == false) {
                          audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                          setState(() {
                            isLoop = true;
                          });
                        } else {
                          audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
                          setState(() {
                            isLoop = false;
                          });
                        }
                      }

                      //  audioPlayer.seek(
                      //   Duration.zero,
                      // ),
                      ),
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    iconSize: 35.0,
                    onPressed: () {
                      setState(() {
                        setState(() {
                          indexloop--;
                          alldata = musicList[indexloop];
                          print(indexloop);
                          playMusic();
                        });
                      });
                    },
                  ),
                  IconButton(
                      iconSize: 35,
                      onPressed: () {
                        audioPlayerState == PlayerState.PLAYING
                            ? showdata
                                ? pauseMusic()
                                : null
                            : showdata
                                ? playMusic()
                                : null;
                      },
                      icon: Icon(audioPlayerState == PlayerState.PLAYING
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded)),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 35.0,
                    onPressed: () {
                      // if(currentIndex<dataList.length){
                      //   currentIndex++;
                      //   pauseMusic();
                      // }
                      print("index beforer next:$indexloop");
                      setState(() {
                        indexloop++;
                        if (indexloop <= musicList.length - 1 &&
                            seletedindex <= musicList.length - 1) {
                          alldata = musicList[indexloop];
                          print(indexloop);
                          playMusic();
                          seletedindex++;
                          // onselectedIndex(indexloop);
                        } else {
                          setState(() {
                            indexloop = 0;
                            seletedindex = 0;
                            alldata = musicList[indexloop];
                            playMusic();
                          });
                        }
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
