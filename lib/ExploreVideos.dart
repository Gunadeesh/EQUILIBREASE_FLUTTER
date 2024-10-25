import 'package:equilibrease/VideoPage.dart';
import 'package:flutter/material.dart';

class ExploreVideos extends StatefulWidget {
  final String patientId;

  ExploreVideos({Key? key, required this.patientId}) : super(key: key);

  @override
  _ExploreVideosState createState() => _ExploreVideosState();
}

class _ExploreVideosState extends State<ExploreVideos> {
  String searchQuery = '';
  List<Video> videos = [
    Video(
      id: 1,
      title: '1. Head side to side',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        /*'English': 'assets/videos/1)Head side to side.mp4',
        'Telugu': 'assets/videos/1)Head side to side.mp4',
        'Hindi': 'assets/videos/1)Head side to side.mp4',
        'Tamil': 'assets/videos/1)Head side to side.mp4',*/
        'English': 'assets/videos/1_Head_side_to_side.mp4',
        'Telugu': 'assets/videos/1_Head_side_to_side.mp4',
        'Hindi': 'assets/videos/1_Head_side_to_side.mp4',
        'Tamil': 'assets/videos/1_Head_side_to_side.mp4',
      },
      captions: {
        'English': 'Head side to side: \n\nWhilst seated, turn your head from side to side...',
        'Telugu': 'తలను వైపు వైపు తిప్పండి: \n\nకూర్చుని ఉండి...',
        // Add captions for Hindi and Tamil...
      },
    ),
    Video(
      id: 2,
      title: '2. Head up & down',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/2)Head up & down.mp4',
        'Telugu': 'assets/videos/2)Head up & down.mp4',
        'Hindi': 'assets/videos/2)Head up & down.mp4',
        'Tamil': 'assets/videos/2)Head up & down.mp4',
      },
      captions: {
        'English': 'Head up and down: \n\nWhilst seated, move your head up and down...',
        'Telugu': 'తల పైకి మరియు కిందకి: \n\nకూర్చుని ఉండగా...',
        // Add captions for Hindi and Tamil...
      },
    ),
    Video(
      id: 3,
      title: '3. Head 45 degree',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/3)Head 45 degree.mp4',
        'Telugu': 'assets/videos/3)Head 45 degree.mp4',
        'Hindi': 'assets/videos/3)Head 45 degree.mp4',
        'Tamil': 'assets/videos/3)Head 45 degree.mp4',
      },
      captions: {
        'English': 'Head 45 degree: \n\nWhilst seated, tilt your head to a 45-degree angle...',
        'Telugu': '45 డిగ్రీలకు తల తిప్పండి: \n\nకూర్చుని ఉండి...',
        // Add captions for Hindi and Tamil...
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Videos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  searchQuery = text;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                if (searchQuery.isNotEmpty &&
                    !video.title.toLowerCase().contains(searchQuery.toLowerCase())) {
                  return SizedBox.shrink(); // Hide item if it doesn't match search
                }
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(video.imagePath),
                    title: Text(video.title),
                    onTap: () {
                      // Navigate to video player screen with required parameters
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPage(
                            patientId: widget.patientId,
                            videoTitle: video.title,
                            videoLanguages: video.languages,
                            videoUris: video.uris,
                            videoCaptions: video.captions,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Video {
  final int id;
  final String title;
  final String imagePath;
  final List<String> languages;
  final Map<String, String> uris;
  final Map<String, String> captions;

  Video({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.languages,
    required this.uris,
    required this.captions,
  });
}
