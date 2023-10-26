import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:glass_kit/glass_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phyo Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpotifyRipOff(),
    );
  }
}

class SpotifyRipOff extends StatefulWidget {
  const SpotifyRipOff({super.key});

  @override
  State<SpotifyRipOff> createState() => _SpotifyRipOffState();
}

class _SpotifyRipOffState extends State<SpotifyRipOff> {
  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();

  //>>>>>>>>>SLIDER
  Duration position = const Duration();
  Duration songLength = const Duration();

  //CUSTOM WIDGET FOR SLIDER
  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        min: 0,
        max: songLength.inSeconds.toDouble(),
        value: position.inSeconds.toDouble(),
        onChanged: (value) {
          seekFunc(value.toInt());
        });
  }

  //SEEK FUNCTION FOR SLIDER <<<<<<
  seekFunc(int sec) {
    Duration newPos = Duration(seconds: sec);
    player.seek(newPos);
  }

  @override
  void initState() {
    //implement initState
    super.initState();
    //this function will allow you to get the music duration
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        playing = state == PlayerState.playing;
      });
    });

    //this function will allow us to move the cursor of the slider while we are playing the song
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        songLength = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  //https://drive.google.com/file/d/{id}/view?usp=sharing

  bool playing = false;
  Icon playBtn = const Icon(Icons.play_arrow, size: 60);

  int songID = 4;

  //PREVIOUS TRACK FUNCTION
  void prevSong() {
    setState(() {
      if (songID <= 0) {
        songID = 4;
      } else {
        songID -= 1;
        // player.play(UrlSource("${songList[songID]['url']}"));
      }
      player.pause();
      position = Duration.zero;
      playing = true;
      playBtn = const Icon(Icons.pause, size: 60);
      player.play(UrlSource("${songList[songID]['url']}"));
    });
  }

  //PLAY PAUSE FUNCTION
  void playSong() {
    setState(() {
      if (playing = !playing) {
        playBtn = const Icon(
          Icons.pause,
          size: 60,
        );
        player.play(UrlSource("${songList[songID]['url']}"));
        // print(">>>>>>>>>> is PLAYING now");
      } else {
        playBtn = const Icon(
          Icons.play_arrow,
          size: 60,
        );
        player.pause();
        // playing = !playing;
        // print("playing is $playing now");
        // print(">>>>>>>>>>> is PAUSED now");
      }
    });
  }

  //NEXT TRACK FUNTION
  void nextSong() {
    setState(() {
      if (songID >= 4) {
        songID = 0;
        // player.play(UrlSource("${songList[songID]['url']}"));
      } else {
        songID += 1;
        // player.play(UrlSource("${songList[songID]['url']}"));
      }
      player.pause();
      position = Duration.zero;
      playing = true;
      playBtn = const Icon(Icons.pause, size: 60);
      player.play(UrlSource("${songList[songID]['url']}"));
    });
  }

  var songList = [
    {
      "url":
          'https://docs.google.com/uc?export=download&id=1cS_LF5KN03hBkjfEIPUs4TfyJOgoMCqV',
      "artist": 'Sleepy Hollow',
      "albumart": 'images/2055.jpg',
      "title": '2055',
    },
    {
      "url":
          'https://docs.google.com/uc?export=download&id=1GpHhcuOwCZ1KqN_IYkogpKT7nqTWEBRf',
      "artist": 'Neiked',
      "albumart": 'images/BETTER_DAYS.jpg',
      "title": 'Better Days',
    },
    {
      "url":
          'https://docs.google.com/uc?export=download&id=10aNvZnxFeSLzVhk4ashah0d6ttCDF8Aq',
      "artist": 'Sekai No Owari and Steve Aoki',
      "albumart": 'images/END_OF_THE_WORLD.jpg',
      "title": 'End Of The World',
    },
    {
      "url":
          'https://docs.google.com/uc?export=download&id=19qNHdKMiplJ_vbUAtRIqAWuCIqff3IrY',
      "artist": 'Pu Sue',
      "albumart": 'images/PUSUE.jpg',
      "title": 'တစ်မိုးအောက်',
    },
    {
      "url":
          'https://docs.google.com/uc?export=download&id=18OOzCJezgHAx8p4xWgMi8WN7oJJSH2k-',
      "artist": 'Thar Sitt',
      "albumart": 'images/THARSITT.jpg',
      "title": 'တဖန်ပြန်ဆက်ဆို',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${songList[songID]['albumart']}"),
            fit: BoxFit.cover,
          ),
        ),
        child: GlassContainer(
          width: screenWidth * 1,
          height: screenHeight * 1,
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 0, 0, 0).withOpacity(0.80),
              const Color.fromARGB(255, 0, 0, 0).withOpacity(0.40)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0),
              Colors.white.withOpacity(0),
              Colors.lightBlueAccent.withOpacity(0),
              Colors.lightBlueAccent.withOpacity(0)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.39, 0.40, 1.0],
          ),
          blur: 15.0,
          borderWidth: 1.5,
          elevation: 3.0,
          shadowColor: Colors.black.withOpacity(0.20),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: Text(
                    "Phyo Music",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage("${songList[songID]['albumart']}"),
                  width: 310,
                  height: 310,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //ARTIST AND SONG TITLE
              Text(
                "${songList[songID]['title']}",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              Text(
                "${songList[songID]['artist']}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(164, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // SLIDER AND BUTTONS

              GlassContainer(
                width: screenWidth * 0.9,
                height: screenHeight * 0.25,
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.40),
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.10)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0),
                    Colors.lightBlueAccent.withOpacity(0),
                    Colors.lightBlueAccent.withOpacity(0)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.39, 0.40, 1.0],
                ),
                blur: 9.0,
                borderWidth: 1.5,
                elevation: 3.0,
                shadowColor: Colors.black.withOpacity(0.20),
                alignment: Alignment.center,
                // SLIDER AND BUTTONS
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          slider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${songLength.inMinutes}:${songLength.inSeconds.remainder(60)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              prevSong();
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          //PLAY PAUSE WILL FUNCTION HERE
                          IconButton(
                            onPressed: () {
                              //play pause function

                              playSong();
                            },
                            icon: playBtn,
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {
                              nextSong();
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
