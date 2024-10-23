import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Ensure you import the http package

class VideoCard extends StatefulWidget {
  const VideoCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  List videos = [];
  List videoShorts = [];
  String selectedCategory = 'default'; // Set a default category

  @override
  void initState() {
    super.initState();
    fetchVideos(); // Fetch videos when the widget is initialized
  }

  Future<void> fetchVideos() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.example.com/videos?category=$selectedCategory'));
      final shortsResponse = await http.get(Uri.parse(
          'https://api.example.com/video-shorts?category=$selectedCategory'));

      if (response.statusCode == 200 && shortsResponse.statusCode == 200) {
        setState(() {
          videos = json.decode(response.body);
          videoShorts = json.decode(shortsResponse.body);
        });
      } else {
        // Handle error
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching videos: $e");
      } // Print error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Video Shorts Section
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videoShorts.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Handle video short tap
                          },
                          child: Card(
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                      videoShorts[index]['thumbnailUrl'] ?? '',
                                      fit: BoxFit.cover),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text(videoShorts[index]['title'] ?? ''),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Full Videos Section
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle full video tap
                  },
                  child: Card(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                              videos[index]['thumbnailUrl'] ?? '',
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(videos[index]['title'] ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
