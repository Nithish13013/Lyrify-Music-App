// homescreen.dart
import 'package:flutter/material.dart';
import 'playlistscreen.dart';
import 'searchscreen.dart'; // <-- Make sure this file exists

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.pngkllkkhjhjhjhjj'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Avatar & Menu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          "https://www.stryx.com/cdn/shop/articles/man-looking-attractive.jpg?v=1666662774",
                        ),
                      ),
                      Icon(Icons.menu, color: Colors.white, size: 28),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Greeting
                  const Text(
                    "Hello Nithish !",
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Find the best songs of 2026",
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar (clickable)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.white70),
                          SizedBox(width: 8),
                          Text(
                            "What do u want to listen",
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Playlist Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Your Playlist",
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Playlist Grid
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1,
                    children: [
                      buildPlaylistCard('images/acrade.PNG'),
                      buildPlaylistCard('images/dandelions.PNG'),
                      buildPlaylistCard('images/divide.PNG'),
                      buildPlaylistCard('images/sttarboy.PNG'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Centered Midnight Vibes text
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Playlistscreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Midnight Vibes',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Top Artists
                  const Text(
                    "Top Artists",
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Top Artists Row
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        artistCircle(
                            'https://starsunfolded.com/wp-content/uploads/2021/04/Duncan-Laurence.jpg'),
                        artistCircle(
                            'https://media.gq-magazine.co.uk/photos/5d1396ffb6fee94ed7c9e909/16:9/w_2560%2Cc_limit/Straboy-GQ-25Nov16_b.jpg'),
                        artistCircle(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHd9b3PiCAthzw6VM7fkwsNaoPZFalaVpvOg&s'),
                        artistCircle(
                            'https://i.scdn.co/image/ab67616d0000b273ef283fbeb261d0a98131a73a'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Playlist Card (Local assets)
  static Widget buildPlaylistCard(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Artist Avatar
  static Widget artistCircle(String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
