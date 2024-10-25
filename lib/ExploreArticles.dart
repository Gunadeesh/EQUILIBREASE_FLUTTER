import 'package:equilibrease/ArticleDetails.dart';
import 'package:flutter/material.dart';

class ExploreArticles extends StatefulWidget {
  final String patientId;

  ExploreArticles({Key? key, required this.patientId}) : super(key: key);

  @override
  _ExploreArticlesState createState() => _ExploreArticlesState();
}
class _ExploreArticlesState extends State<ExploreArticles> {
  final TextEditingController searchController = TextEditingController();

  // Articles data here...
  final List<Map<String, dynamic>> articles = [
    {
      'id': 1,
      'title': '1. What is Vertigo?',
      'image': 'assets/article1.png', // Use AssetImage for loading images in Flutter
      'detailImage': 'assets/Vertigoartcile1.png',
      'content': 'Understanding Vertigo:\n Symptoms, Triggers, and When to See a Doctor:\n Vertigo is characterized by a false sensation of movement, such as spinning or tilting, and is often linked to dizziness. Patients may also experience lightheadedness, imbalance, and a sense of near fainting (presyncope), leading to falls. The intensity and frequency of vertigo vary; some patients have short, mild episodes, while others suffer more severe, frequent attacks that interfere with daily life. Common causes include inner ear problems like benign paroxysmal positional vertigo, labyrinthitis, and Ménière’s disease. Consult a healthcare professional to pinpoint and manage the cause of vertigo, especially if symptoms become severe, including double vision, hearing issues, or difficulty walking.',
      'references': '''1. Salvinelli F, Firrisi, M Casale, M Trivelli, L D'Ascanio, F Lamanna, F Greco, Costantino S. "What is vertigo?" Clin Ter. 2003;154(5): 341-348.
    2. Bateman K, Rogers C, Meyer E. An approach to acute vertigo. S Afr Med J. 2015;105(8):694.
    3. RACGP- An approach to vertigo in general practice. https://www.racgp.org.au/afp/2016/april/an-approach-to-vertigo-in-general-practice/. Published 2020. Accessed October 28, 2020.
    4. NHS. Vertigo, nhs.uk. https://www.nhs.uk/conditions/vertigo/. Published 2020. Accessed October 14, 2020.'''
    },
    {
      'id': 2,
      'title': '2. What factor can trigger vertigo?',
      'image': 'assets/article2.png',
      'detailImage': 'assets/Vertigoartcile1.png',
      'content': 'Triggers and Risk Factors for Vertigo: \n \n Vertigo is usually linked to various diseases or medication side effects, highlighting the importance of seeking medical advice for an accurate diagnosis and treatment plan. The most common triggers are inner ear conditions like BPPV, vestibular neuronitis, Ménière’s disease, and migraines. Other triggers include pregnancy, multiple sclerosis, dehydration, low blood sugar, Parkinson’s disease, head and neck injuries, stroke, hypertension, and diabetes. Factors that increase the likelihood of vertigo include aging, hormonal changes in women, unhealthy eating habits, stress, anxiety, head movements, and genetic predispositions. Immediate consultation with a doctor is recommended for proper diagnosis and management.',
      'references': '''1. Medscape. Vertigo: Identifying the Hidden Cause. https://reference.medscape.com/slideshow/vertigo-6001144#7. Published 2020. Accessed October 29, 2020.
    2. Bhattacharyya N, Gubbels S, Schwartz S et al. Clinical Practice Guideline: Benign Paroxysmal Positional Vertigo (Update) Executive Summary. Otolaryngol Head Neck Surg. 2017;156(3):403-416.
    3. NHS. Labyrinthitis and vestibular neuritis. nhs.uk. https://www.nhs.uk/conditions/labyrinthitis/. Published 2020. Accessed October 14, 2020.
    4. Smith T, Rider J, Cen S. Vestibular Neuronitis (Labyrinthitis). https://www.ncbi.nlm.nih.gov/books/NBK549866/. Published 2010. Accessed October 14, 2020.
    5. Vestibular Disorders Association. Vestibular Migraine. https://vestibular.org/article/diagnosis-treatment/types-of-vestibular-disorders/vestibular-migraine/. Published 2020. Accessed October 28, 2020.'''
    },
    {
      'id': 3,
      'title': '3. How to manage a vertigo attack?',
      'image': 'assets/article1.png',
      'detailImage': 'assets/Vertigoartcile1.png',
      'content': 'Tips for Managing Vertigo Attacks: \n \n Sudden vertigo episodes can be alarming, but adopting specific behaviors can help reduce their intensity and prevent future stress. During an attack, lie down in a quiet, dark room to alleviate spinning sensations. If driving, pull over safely and relax. Move your head slowly in daily tasks, avoid bright lights and loud noises, and reduce visual stress from screens. Sit immediately if dizzy, turn on lights when getting up at night, and sleep with your head slightly elevated. For those with frequent episodes, installing safety features like grab bars and clear pathways can reduce fall risks. Always seek medical attention if severe symptoms occur, and follow up with your doctor after an episode to manage vertigo effectively.',
      'references': '''1. New Health Service. Vertigo. https://www.nhs.uk/conditions/vertigo/. Published 2020. Accessed October 21, 2020.
    2. Vestibular Disorders Association. How Light Sensitivity & Photophobia Affect Vestibular Disorders. https://vestibular.org/how-light-sensitivity-photophobia-affect-vestibular-disorders/. Accessed October 21, 2020.
    3. Lakeline NeuroVisual Medicine. Dizzy While Driving. https://www.neurovisionaustin.com. Published 2020. Accessed October 21, 2020.
    4. Hopkins Medicine. Recent Findings. https://www.hopkinsmedicine.org. Published 2020. Accessed October 21, 2020.
    5. Horinaka A, Kitahara T, Shiozaki T, et al. Head-Up Sleep May Cure Patients with Intractable Benign Paroxysmal Positional Vertigo: A Six-Month Randomized Trial. Laryngoscope Investig Otolaryngol. 2019;4(3):353-358.
    6. Stross K. Fall Prevention & Home Safety for Those with Vestibular Disorders. Vestibular Disorders Association. https://vestibular.org/sites/default/files/page_files/Documents/Fall-Prevention-and-Home-Safety_101.pdf'''
    },
    {
      'id': 4,
      'title': '4. How long does vertigo last?',
      'image': 'assets/article1.png',
      'detailImage': 'assets/Vertigoartcile1.png',
      'content': 'How Long Can Vertigo Last and What Causes It? \n \n Vertigo episodes can vary in duration, from a few seconds to weeks, largely depending on the cause. BPPV, the most common form, involves brief spinning triggered by head movements, often lasting seconds. Ménière’s disease, linked to ear ringing or pressure, results in episodes lasting between 20 minutes and a few hours. Vestibular migraines can cause severe dizziness for minutes, hours, or even days, often accompanied by nausea and blurred vision. Vestibular neuronitis, due to inner ear infections, can cause prolonged spinning lasting hours to days, peaking within 24-48 hours. Although rare, severe vertigo can last months if not treated. Consulting a doctor is vital to diagnose the cause and manage symptoms effectively.',
      'references': '''1. Royal Australian College of General Practitioners. An Approach to Vertigo in General Practice. https://www.recep.org.au/afp/2016/april/an-approach-to-vertigo-in-general-practice/, Published 2020. Accessed October 28, 2020.
    2. Bateman K, Rogers C, Meyer E. An Approach to Acute Vertigo. S Afr Med J. 2015:05(8):694.
    3. Ménière's Society, Vestibular Migraine. https://www.menieres.org.uk/information-and-support/symptoms-and-conditions/migraine-associated-vertigo. Published 2020. Accessed October 28, 2020.
    4. Smith T, Rider J, et al. Vestibular Neuronitis. Published 2020. https://www.ncbi.nlm.nih.gov/books/NBKS49866/ Accessed October 28,2020.
    5. New Health Service. Vertigo. https://www.nhs.uk/conditions/vertigo/#text=Vertigo%20feels%20like%20you%20or%20for%20many%20days%20or%20months. Published 2020. Accessed November 6, 2020.
    6. Wetchester Medical Center, Balance Issues. https://www.wmchealthass.com/common-balance-issues- Published 2020. Accessed November 6, 2020.'''
    },
    {
      'id': 5,
      'title': '5. Types of Vertigo?',
      'image': 'assets/article1.png',
      'detailImage': 'assets/Vertigoartcile1.png',
      'content': 'Types of Vertigo: Understanding the Differences \n \n Vertigo can be categorized into various types based on its causes and manifestations. 1. **Peripheral Vertigo**: Caused by issues in the inner ear, including BPPV and Ménière’s disease, leading to sudden, severe symptoms. 2. **Central Vertigo**: Results from problems in the brain, like strokes or tumors, causing persistent symptoms that may not worsen with head movement. 3. **Vestibular Migraine**: Characterized by dizziness and associated migraine symptoms like headache and nausea. 4. **Motion Sickness**: Triggered by movement, causing dizziness and nausea, common in travel situations. 5. **Cervicogenic Vertigo**: Linked to neck issues, causing dizziness due to muscle and joint problems. Distinguishing between these types is crucial for effective management and treatment.',
      'references': '''1. Martin M, Hentze J, et al. Classification of Vertigo. J Neurol. 2018;265(5):1256-1263.
    2. Barin K. The Clinical Spectrum of Vertigo. Phys Med Rehabil Clin N Am. 2018;29(4):637-650.
    3. ClinicalKey. Vertigo: An Overview. https://www.clinicalkey.com. Published 2020. Accessed October 28, 2020.
    4. Headache & Migraine Center. https://www.hhc.org/healthcare/neurology/vertigo-dizziness/. Accessed October 28, 2020.
    5. Veda Institute. Vestibular Migraine. https://www.vedausa.org/migraine.htm. Published 2020. Accessed October 28, 2020.'''
    },
    {
      'id': 6,
      'title': '6. Why is adherence to treatment important in vertigo?',
      'image': 'assets/article2.png', // Use AssetImage for local images
      'detailImage': 'assets/Vertigoartcile1.png', // Use AssetImage for local images
      'content': 'Adhering to Treatment for Effective Vertigo Management: \n \n Adherence involves taking your medication and following your doctor’s recommendations to manage vertigo. It starts with working with your doctor to pinpoint the root cause of your symptoms and agreeing on a treatment strategy that may include medication and specific exercises. Once you begin treatment, follow the prescribed doses, timing, and duration to ensure effectiveness. If you experience challenges, talk to your doctor rather than altering the treatment on your own. Stopping treatment prematurely or incorrect medication use can have negative effects. Remember, treatment adherence also includes maintaining a healthy lifestyle, which is just as crucial as medication.',
      'references': '''1. Lindenfeld J., Jessup M. Drugs don't work in patients who don't take them (C. Everett Koop, MD, JS Surgeon, General, 1985). Eur J Heart Fail, 2017, 19:1412-1413.
    2. Jimmy B., Jameny J. Patient medication adherence: Measures in daily practice. Omen Med J 2011 2603): 155-159.
    3. Kovars F, Wang X, Grill F. Economic burden of vertigo: a systematic review. Health Econ Rev 2019, 90): 37.
    4. Cetiri Y, Ozmen O, Dernier U., Kasepuglu F, Bosut Q, Coskun H. Comparison of the effectiveness of Brands Durulf Vestibular training and Epley Canalith repositioning maneuver in benign Paroxysmal positional vertigo long term results: A randomized prospective clinical trial. Pak Med Sci 2018: 34(3):558-563.
    5. Ba...'''
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Articles'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (query) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to ArticleDetails page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetails(
                          title: article['title'], // Title from the article map
                          image: article['detailImage'], // Ensure this is a string path
                          content: article['content'], // Content from the article map
                          references: article['references'], // References from the article map
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Image.asset(
                          article['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            article['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
