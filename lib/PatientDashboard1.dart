import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // GetX package for navigation
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
      'DoctorRepliesScreen',  // Ensure this matches the registered route.
      arguments: widget.patientId, // Pass only the patient ID as a string.
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
      appBar: AppBar(
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
        child: Column(
          children: [
            Image.asset('assets/dashboardimage.png'),
            const SizedBox(height: 10),
            _buildVideosSection(),
            const SizedBox(height: 20),
            _buildArticlesSection(),
          ],
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
        'thumbnail': 'assets/video1.png',
      },
      {
        'id': 3,
        'title': '3. Head 45 degree',
        'thumbnail': 'assets/video1.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Videos:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              print('Navigating to ExploreVideos with patientId: ${widget.patientId}');
              Get.toNamed(
                '/ExploreVideos',
                arguments: {'patientId': widget.patientId},
              );
            },
            child: const Text('View all →'),
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
          const SizedBox(height: 8),
          Text(
            video['title'] as String,
            style: const TextStyle(fontSize: 16),
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
        'detailImage': 'assets/Vertigoartcile1.png',
        'content': '''Understanding Vertigo:
Symptoms, Triggers, and When to See a Doctor:
Vertigo is characterized by a false sensation of movement, such as spinning or tilting, and is often linked to dizziness. Patients may also experience lightheadedness, imbalance, and a sense of near fainting (presyncope), leading to falls. The intensity and frequency of vertigo vary; some patients have short, mild episodes, while others suffer more severe, frequent attacks that interfere with daily life. Common causes include inner ear problems like benign paroxysmal positional vertigo, labyrinthitis, and Ménière’s disease. Consult a healthcare professional to pinpoint and manage the cause of vertigo, especially if symptoms become severe, including double vision, hearing issues, or difficulty walking.''',
        'references': '''1. Salvinelli F, Firrisi, M Casale, M Trivelli, L D'Ascanio, F Lamanna, F Greco, Costantino S. "What is vertigo?" Clin Ter. 2003;154(5): 341-348.
2. Bateman K, Rogers C, Meyer E. An approach to acute vertigo. S Afr Med J. 2015;105(8):694.
3. RACGP- An approach to vertigo in general practice. https://www.racgp.org.au/afp/2016/april/an-approach-to-vertigo-in-general-practice/. Published 2020. Accessed October 28, 2020.
4. NHS. Vertigo, nhs.uk. https://www.nhs.uk/conditions/vertigo/. Published 2020. Accessed October 14, 2020.''',
      },
      {
        'id': 2,
        'title': '2. What factor can trigger vertigo?',
        'image': 'assets/article2.png',
        'detailImage': 'assets/Vertigoartcile1.png',
        'content': '''Triggers and Risk Factors for Vertigo:

Vertigo is usually linked to various diseases or medication side effects, highlighting the importance of seeking medical advice for an accurate diagnosis and treatment plan. The most common triggers are inner ear conditions like BPPV, vestibular neuronitis, Ménière’s disease, and migraines. Other triggers include pregnancy, multiple sclerosis, dehydration, low blood sugar, Parkinson’s disease, head and neck injuries, stroke, hypertension, and diabetes. Factors that increase the likelihood of vertigo include aging, hormonal changes in women, unhealthy eating habits, stress, anxiety, head movements, and genetic predispositions. Immediate consultation with a doctor is recommended for proper diagnosis and management.''',
        'references': '''1. Medscape. Vertigo: Identifying the Hidden Cause. https://reference.medscape.com/slideshow/vertigo-6001144#7. Published 2020. Accessed October 29, 2020.
2. Bhattacharyya N, Gubbels S, Schwartz S et al. Clinical Practice Guideline: Benign Paroxysmal Positional Vertigo (Update) Executive Summary. Otolaryngol Head Neck Surg. 2017;156(3):403-416.
3. NHS. Labyrinthitis and vestibular neuritis. nhs.uk. https://www.nhs.uk/conditions/labyrinthitis/. Published 2020. Accessed October 14, 2020.
4. Smith T, Rider J, Lee L, et al. Vestibular Disorders. In: Cummings Otolaryngology: Head and Neck Surgery. 6th ed. Elsevier; 2020:450-463.''',
      },
      {
        'id': 3,
        'title': '3. How to manage a vertigo attack?',
        'image': 'assets/article1.png',
        'detailImage': 'assets/Vertigoartcile1.png',
        'content': '''Tips for Managing Vertigo Attacks:

Sudden vertigo episodes can be alarming, but adopting specific behaviors can help reduce their intensity and prevent future stress. During an attack, lie down in a quiet, dark room to alleviate spinning sensations. If driving, pull over safely and relax. Move your head slowly in daily tasks, avoid bright lights and loud noises, and reduce visual stress from screens. Sit immediately if dizzy, turn on lights when getting up at night, and sleep with your head slightly elevated. For those with frequent episodes, installing safety features like grab bars and clear pathways can reduce fall risks. Always seek medical attention if severe symptoms occur, and follow up with your doctor after an episode to manage vertigo effectively.''',
        'references': '''1. New Health Service. Vertigo. https://www.nhs.uk/conditions/vertigo/. Published 2020. Accessed October 21, 2020.
2. Vestibular Disorders Association. How Light Sensitivity & Photophobia Affect Vestibular Disorders. https://vestibular.org/how-light-sensitivity-photophobia-affect-vestibular-disorders/. Accessed October 21, 2020.
3. Lakeline NeuroVisual Medicine. Dizzy While Driving. https://www.neurovisionaustin.com. Published 2020. Accessed October 21, 2020.
4. Hopkins Medicine. Recent Findings. https://www.hopkinsmedicine.org. Published 2020. Accessed October 21, 2020.
5. Horinaka A, Kitahara T, Shiozaki T, et al. Head-Up Sleep May Cure Patients with Intractable Benign Paroxysmal Positional Vertigo: A Six-Month Randomized Trial. Laryngoscope Investig Otolaryngol. 2019;4(3):353-358.
6. Stross K. Fall Prevention & Home Safety for Those with Vestibular Disorders. Vestibular Disorders Association. https://vestibular.org/sites/default/files/page_files/Documents/Fall-Prevention-and-Home-Safety_101.pdf''',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Articles:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              print('Navigating to ExploreArticles with patientId: ${widget.patientId}');
              Get.toNamed(
                '/ExploreArticles',
                arguments: {'patientId': widget.patientId},
              );
            },
            child: const Text('View all →'),
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
          const SizedBox(height: 8),
          Text(
            article['title'] as String,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
