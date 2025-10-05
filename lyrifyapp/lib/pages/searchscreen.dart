import 'package:flutter/material.dart';
import 'playerscreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // A copy of the playlist data to use for searching
  final List<Map<String, String>> allSongs = const [
    {
      'title': 'Dandelions',
      'artist': 'Ruth B',
      'image': 'images/dandelions.PNG',
      'audio': 'assets/audio/Dandelions.mp3',
    },
    {
      'title': 'Star Boy',
      'artist': 'Weekend',
      'image': 'images/sttarboy.PNG', // Placeholder image
      'audio': 'assets/audio/starboyori.mp3', // Placeholder audio
    },
    {
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'image': 'images/divide.PNG', // Placeholder image
      'audio': 'assets/audio/shape of you.mp3', // Placeholder audio
    },
  
    {
      'title': 'Summertime',
      'artist': 'Lana Del Rey',
      'image': 'images/summertime.PNG',
      'audio': 'assets/audio/Summertimesadness.mp3',
    },
  
   
  ];

  List<Map<String, String>> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially show the full list (or no results, but full list resembles the image better)
    searchResults = allSongs; 
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, display the initial, full list (as seen in the image)
        searchResults = allSongs;
      } else {
        searchResults = allSongs
            .where((song) =>
                song['title']!.toLowerCase().contains(query) ||
                song['artist']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the search screen
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search for songs, artists, or playlists',
                          hintStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Colors.white70),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, color: Colors.white70),
                                  onPressed: () {
                                    _searchController.clear();
                                    _onSearchChanged();
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Add a filter/menu icon to match the style
                  const Icon(Icons.more_vert, color: Colors.white, size: 24),
                ],
              ),
            ),
            
            // Search Results List
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final song = searchResults[index];
                  // If the list is a mixture of songs and other things, 
                  // you'll need logic to differentiate. For now, all are songs.
                  
                  // This is the style from the image:
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the player screen with the selected song's index
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Playerscreen(
                            playlist: searchResults, // Pass the search results as the new playlist
                            currentIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // Album Art/Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              song['image']!, // Assuming you have placeholder images
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey,
                                  child: const Icon(Icons.music_note, color: Colors.white),
                                );
                              }
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // Title and Subtitle
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song['title']!,
                                style: const TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                // Assuming 'Song' or 'Playlist' + '•' + artist/creator
                                'Song • ${song['artist']!}',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Spacer(),
                          
                          // Trailing Icons
                          IconButton(
                            icon: const Icon(Icons.more_vert, color: Colors.white70),
                            onPressed: () {
                              // Handle menu action
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
                            onPressed: () {
                              // Handle add to playlist action
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}