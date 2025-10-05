

import 'package:flutter/material.dart';
import 'playerscreen.dart';

class Playlistscreen extends StatelessWidget {
  const Playlistscreen({super.key});

  final List<Map<String, String>> playlist = const [
    {
      'title': 'Dandelions',
      'artist': 'Ruth B',
      'image': 'images/dandelions.PNG',
      'audio': 'assets/audio/Dandelions.mp3',
    },
    {
      'title': 'Star Boy',
      'artist': 'Weekend',
      'image': 'images/sttarboy.PNG',
      'audio': 'assets/audio/starboyori.mp3',
    },
    {
      'title': 'Acrade',
      'artist': 'Duncan laurence',
      'image': 'images/acrade.PNG',
      'audio': 'assets/audio/acrade.mp3',
    },
    {
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'image': 'images/divide.PNG',
      'audio': 'assets/audio/shape of you.mp3',
    },
    {
      'title': 'Summertime',
      'artist': 'Lana Del Rey',
      'image': 'images/summertime.PNG',
      'audio': 'assets/audio/Summertimesadness.mp3',
    },
  ];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
                    SizedBox(width: 12),
                    Text(
                      'My Playlist',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Midnight Vibes',
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: playlist.length,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    final song = playlist[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Playerscreen(
                              playlist: playlist,
                              currentIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                song['image']!,
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song['title']!,
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  song['artist']!,
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          playlist[2]['image']!,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist[2]['title']!,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            playlist[2]['artist']!,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.pause, color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}