
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class Playerscreen extends StatefulWidget {
  final List<Map<String, String>> playlist;
  final int currentIndex;

  const Playerscreen({
    super.key,
    required this.playlist,
    required this.currentIndex,
  });

  @override
  State<Playerscreen> createState() => _PlayerscreenState();
}

class _PlayerscreenState extends State<Playerscreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  late int songIndex;

  Map<String, String> get currentSong => widget.playlist[songIndex];

  @override
  void initState() {
    super.initState();
    songIndex = widget.currentIndex;
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
    _playSong();
  }

  Future<void> _playSong() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(currentSong['audio']!.replaceFirst('assets/', '')));
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void _nextSong() {
    if (songIndex < widget.playlist.length - 1) {
      setState(() {
        songIndex++;
      });
      _playSong();
    }
  }

  void _prevSong() {
    if (songIndex > 0) {
      setState(() {
        songIndex--;
      });
      _playSong();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFE7C3B),
              Color(0xFF0B234A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Now Playing',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  currentSong['image']!,
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong['title']!,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          currentSong['artist']!,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.favorite_border, color: Colors.white, size: 28),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Slider(
                      value: position.inSeconds.toDouble(),
                      min: 0,
                      max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white24,
                      onChanged: (value) async {
                        await _audioPlayer.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTime(position),
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          _formatTime(duration),
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, color: songIndex > 0 ? Colors.white : Colors.white24, size: 36),
                    onPressed: songIndex > 0 ? _prevSong : null,
                  ),
                  SizedBox(width: 32),
                  GestureDetector(
                    onTap: () {
                      if (isPlaying) {
                        _pauseSong();
                      } else {
                        _playSong();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 32),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: songIndex < widget.playlist.length - 1 ? Colors.white : Colors.white24, size: 36),
                    onPressed: songIndex < widget.playlist.length - 1 ? _nextSong : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}