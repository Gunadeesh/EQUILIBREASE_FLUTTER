import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'config.dart';

class PatientDashboard1 extends StatefulWidget {
  final String? patientId;

  const PatientDashboard1({Key? key, this.patientId}) : super(key: key);

  @override
  _PatientDashboard1State createState() => _PatientDashboard1State();
}

class _PatientDashboard1State extends State<PatientDashboard1> {
  String patientName = '';
  String? patientImage;
  bool isLoading = true;
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (widget.patientId != null && widget.patientId != 'guest') {
      try {
        final patientResponse = await http.get(
          Uri.parse(Config.patientDashboard(widget.patientId!)),
        );
        final patientData = jsonDecode(patientResponse.body);

        setState(() {
          patientName = patientData['patientName'];
          patientImage =
          '${patientData['patientImage']}?timestamp=${DateTime.now().millisecondsSinceEpoch}';
        });

        final notificationResponse = await http.get(
          Uri.parse(Config.getNotificationCountDoctor(widget.patientId!)),
        );
        final notificationData = jsonDecode(notificationResponse.body);

        setState(() {
          notificationCount = notificationData['count'];
          isLoading = false;
        });
      } catch (error) {
        print('Error fetching data: $error');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        patientName = 'Guest';
        isLoading = false;
      });
    }
  }

  void _handleNotificationClick() {
    Navigator.pushNamed(
      context,
      '/doctorReplies',
      arguments: widget.patientId,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.patientId == null) {
      return const Center(
        child: Text(
          'Patient ID is not defined',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC5EDFE),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: patientImage != null
                  ? NetworkImage(patientImage!)
                  : const AssetImage('assets/Patientimg.png') as ImageProvider,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Welcome, $patientName',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: _handleNotificationClick,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/dashboardimage.png', height: MediaQuery.of(context).size.height * 0.3),
              const SizedBox(height: 10),
              _buildVideosSection(),
              const SizedBox(height: 10),
              _buildArticlesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideosSection() {
    final videos = [
      {
        'id': 1,
        'title': '1. Head side to side',
        'thumbnail': 'assets/video1.png',
      },
      {
        'id': 2,
        'title': '2. Head up & down',
        'thumbnail': 'assets/video2.png',
      },
      {
        'id': 3,
        'title': '3. Head 45 degree',
        'thumbnail': 'assets/video1.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Videos:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF458ADB).withOpacity(0.67),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return _buildVideoCard(video);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(
                        '/ExploreVideos',
                        arguments: {'patientId': widget.patientId},
                      );
                    },
                    child: const Text(
                      'View all →',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesSection() {
    final articles = [
      {
        'id': 1,
        'title': '1. What is Vertigo?',
        'image': 'assets/article1.png',
      },
      {
        'id': 2,
        'title': '2. What factor can trigger vertigo?',
        'image': 'assets/article2.png',
      },
      {
        'id': 3,
        'title': '3. How to manage a vertigo attack?',
        'image': 'assets/article1.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Articles:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF458ADB).withOpacity(0.67),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return _buildArticleCard(article);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(
                        '/ExploreArticles',
                        arguments: {'patientId': widget.patientId},
                      );
                    },
                    child: const Text(
                      'View all →',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, Object> video) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            video['thumbnail'] as String,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            video['title'] as String,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(Map<String, Object> article) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            article['image'] as String,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            article['title'] as String,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
