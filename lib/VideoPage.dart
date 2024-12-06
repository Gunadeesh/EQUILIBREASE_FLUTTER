import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String? patientId;
  final String videoId;
  final String videoTitle;
  final List<String> videoLanguages;
  final Map<String, String> videoUris;
  final Map<String, String> videoCaptions;

  const VideoPage({
    Key? key,
    required this.patientId,
    required this.videoId,
    required this.videoTitle,
    required this.videoLanguages,
    required this.videoUris,
    required this.videoCaptions,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String? selectedLanguage;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
  }

  void _initializeVideo(String language) {
    if (_videoController != null) {
      _videoController!.dispose();
    }
    _videoController = VideoPlayerController.asset(widget.videoUris[language]!)
      ..initialize().then((_) {
        setState(() {
          _videoController?.play();
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void toggleLanguage(String language) {
    setState(() {
      selectedLanguage = language;
      _initializeVideo(language);
    });
  }

  void handleButtonPress() {
    if (widget.patientId == 'guest') {
      Get.offAndToNamed('/PatientDrawer', arguments: {'patientId': widget.patientId});
    } else {
      Get.toNamed(
        '/FeedbackScreen',
        arguments: {
          'videoId': widget.videoId,
          'patientId': widget.patientId,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double windowHeight = MediaQuery.of(context).size.height;
    final double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button with left and top padding
              Padding(
                padding: EdgeInsets.only(left: windowWidth * 0.01, top: windowHeight * 0.03),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    'assets/backarrow.png',
                    width: windowWidth * 0.18,
                    height: windowWidth * 0.08,
                  ),
                ),
              ),
              // Video Title
              Container(
                margin: EdgeInsets.symmetric(vertical: windowHeight * 0.03),
                padding: EdgeInsets.symmetric(vertical: windowHeight * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.videoTitle,
                    style: TextStyle(
                      fontSize: windowWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Video Player or Placeholder Image
              if (selectedLanguage != null && _videoController != null && _videoController!.value.isInitialized)
                AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
              else
                Image.asset(
                  'assets/videoscrren.png',
                  width: double.infinity,
                  height: windowHeight * 0.3,
                  fit: BoxFit.cover,
                ),
              // Captions Section
              Container(
                margin: EdgeInsets.only(top: windowHeight * 0.02),
                padding: EdgeInsets.all(windowWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: selectedLanguage != null
                    ? SingleChildScrollView(
                  child: Text(
                    widget.videoCaptions[selectedLanguage!] ?? '',
                    style: TextStyle(
                      fontSize: windowWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
                    : Column(
                  children: widget.videoLanguages.map((language) {
                    return Row(
                      children: [
                        Checkbox(
                          value: selectedLanguage == language,
                          onChanged: (value) {
                            if (value!) toggleLanguage(language);
                          },
                        ),
                        Text(
                          language,
                          style: TextStyle(
                            fontSize: windowWidth * 0.04,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              // Centered Next/Done Button
              if (selectedLanguage != null)
                Padding(
                  padding: EdgeInsets.only(top: windowHeight * 0.03),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                            vertical: windowWidth * 0.03, horizontal: windowWidth * 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: handleButtonPress,
                      child: Text(
                        widget.patientId == 'guest' ? 'Done' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: windowWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
