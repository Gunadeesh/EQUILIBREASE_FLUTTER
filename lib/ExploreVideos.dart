import 'VideoPage.dart';
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
      id: '1',
      title: '1. Head side to side',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/1_Head_side_to_side.mp4',
        'Telugu': 'assets/videos/1_Head_side_to_side.mp4',
        'Hindi': 'assets/videos/1_Head_side_to_side.mp4',
        'Tamil': 'assets/videos/1_Head_side_to_side.mp4',
      },
      captions: {
        'English': '1: `Head side to side: \n \nWhilst seated, turn your head from side to side. First slowly, then gradually increase speed according to your own pace.\nDo this with eyes open, then repeat with eyes closed.\nPOINT 1:\nThese exercises are to help with vestibular dysfunction NOT due to BPPV or Ménières disease.`',
        'Telugu': '1: `తలను వైపు వైపు తిప్పండి: \n \nకూర్చుని ఉండి, మీ తలను వైపు వైపు తిప్పండి. మొదట నెమ్మదిగా, తరువాత మీ స్వంత వేగానికి అనుగుణంగా క్రమంగా వేగాన్ని పెంచండి.\n కళ్ళు తెరిచి ఉండగా ఇది చేయండి, తరువాత కళ్ళు మూసి తిరిగి చేయండి.\n పాయింట్ 1:\n ఈ వ్యాయామాలు BPPV లేదా మెనియర్ వ్యాధి కారణమైన వెస్టిబ్యులర్ అసాధారణతకు సంబంధించినవి కాదు.`',
        'Hindi':'1: `सिर को दाएं-बाएं घुमाएं: \n \nबैठे हुए, अपने सिर को दाएं-बाएं घुमाएं। पहले धीरे-धीरे, फिर अपनी गति के अनुसार धीरे-धीरे गति बढ़ाएं।\n इसे आंखें खुली रखते हुए करें, फिर आंखें बंद करके दोबारा करें।\n बिंदु 1:\n ये व्यायाम BPPV या मेनियर रोग के कारण होने वाले वेस्टिबुलर दोष के लिए नहीं हैं।`',
        'Tamil':'1: `தலைக்கு முறைமுறை திருப்பவும்: \n \nஎழுந்திருக்கும் போது, உங்கள் தலைவை இரு طرفகளுக்கும் திருப்பவும். முதலில் மெதுவாக, பிறகு உங்கள் சொந்த வேகத்திற்கு ஏற்ப அதிகரிக்கவும்.\n இது திறந்த கண்களுடன் செய்யவும், பிறகு மூடிய கண்களுடன் மீண்டும் செய்யவும்.\n பாயிண்ட் 1:\n இந்த பயிற்சிகள் BPPV அல்லது மெனியர் நோய் காரணமாக ஏற்படும் வெஸ்டிப்யுலர் பாதிப்புக்கு அல்ல.`',
      },
    ),
    Video(
      id: '2',
      title: '2. Head up & down',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/2_Head_up_and_down.mp4',
        'Telugu': 'assets/videos/2_Head_up_and_down.mp4',
        'Hindi': 'assets/videos/2_Head_up_and_down.mp4',
        'Tamil': 'assets/videos/2_Head_up_and_down.mp4',
      },
      captions: {
        'English': '2: `Head up and down: \n \nWhilst seated, move your head up and down. First slowly, then gradually increase speed according to your own pace.\nDo this with eyes open, then repeat with eyes closed.\nPOINT 2:\nThese exercises start out very easy but by exercise 6 become more difficult.`,',
        'Telugu': '2: `తల పైకి మరియు కిందకి: \n \nకూర్చుని ఉండగా, మీ తలను పైకి మరియు కిందకి కదిలించండి. మొదట నెమ్మదిగా, తరువాత మీ స్వంత వేగానికి అనుగుణంగా క్రమంగా వేగాన్ని పెంచండి.\n కళ్ళు తెరిచి ఉండగా ఇది చేయండి, తరువాత కళ్ళు మూసి తిరిగి చేయండి.\n పాయింట్ 2:\n ఈ వ్యాయామాలు మొదట చాలా సులభంగా ఉంటాయి కానీ 6వ వ్యాయామానికి అవి కష్టం అవుతాయి.',
        'Hindi':'2:`सिर ऊपर और नीचे: \n \nबैठे हुए, अपने सिर को ऊपर और नीचे हिलाएं। पहले धीरे-धीरे, फिर अपनी गति के अनुसार धीरे-धीरे गति बढ़ाएं।\n इसे आंखें खुली रखते हुए करें, फिर आंखें बंद करके दोबारा करें।\n बिंदु 2:\n ये व्यायाम शुरुआत में बहुत आसान होते हैं, लेकिन व्यायाम 6 तक पहुँचते-पहुँचते मुश्किल हो जाते हैं।`',
        'Tamil':'2: `தலை மேலே மற்றும் கீழே: \n \nஉட்கார்ந்தபடி, உங்கள் தலைவை மேலே மற்றும் கீழே நகர்த்துங்கள். முதலில் மெதுவாக, பிறகு உங்கள் சொந்த வேகத்திற்கு ஏற்ப மெதுவாகவே வேகம் அதிகரிக்கவும்.\n இது திறந்த கண்களுடன் செய்யவும், பிறகு மூடிய கண்களுடன் மீண்டும் செய்யவும்.\n பாயிண்ட் 2:\n இந்த பயிற்சிகள் தொடக்கத்தில் மிகவும் எளிதாக இருக்கும், ஆனால் 6வது பயிற்சிக்குப் பிறகு சிரமமாக மாறும்.`',
      },
    ),
    Video(
      id: '3',
      title: '3. Head 45 degree',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/3_Head_45_degree.mp4',
        'Telugu': 'assets/videos/3_Head_45_degree.mp4',
        'Hindi': 'assets/videos/3_Head_45_degree.mp4',
        'Tamil': 'assets/videos/3_Head_45_degree.mp4',
      },
      captions: {
        'English': '3: `Head 45 degree: \n \nWhilst seated, turn your head 45° to look over your left shoulder and move your head up and down. First slowly, then gradually increase the speed according to your own pace.\nDo this with eyes open, then repeat with eyes closed. Repeat whilst looking over your right shoulder.\nPOINT 3:\nIt is not unusual for these exercises to aggravate the sensation of dizziness, but dont give up.`',
        'Telugu': '3:`తల 45 డిగ్రీ: \n \nకూర్చుని ఉండి, మీ తలను 45° ఎడమ భుజం మీద చూడటానికి తిప్పండి మరియు మీ తలను పైకి మరియు కిందకి కదిలించండి. మొదట నెమ్మదిగా, తరువాత మీ స్వంత వేగానికి అనుగుణంగా క్రమంగా వేగాన్ని పెంచండి.\n కళ్ళు తెరిచి ఉండగా ఇది చేయండి, తరువాత కళ్ళు మూసి తిరిగి చేయండి. మీరు కుడి భుజం మీద చూస్తున్నప్పుడు మళ్లీ చేయండి.\n పాయింట్ 3:\n ఈ వ్యాయామాలు చలనం అనుభవాన్ని పెంచవచ్చు, కానీ దిగులు పడకండి.`',
        'Hindi':'3: `सिर 45 डिग्री: \n \nबैठे हुए, अपने सिर को 45° बाईं ओर घुमाएं ताकि आप अपने बाएं कंधे को देख सकें और अपने सिर को ऊपर और नीचे हिलाएं। पहले धीरे-धीरे, फिर अपनी गति के अनुसार धीरे-धीरे गति बढ़ाएं।\n इसे आंखें खुली रखते हुए करें, फिर आंखें बंद करके दोबारा करें। दाईं ओर देखते समय इसे फिर से करें।\n बिंदु 3:\n इन व्यायामों से चक्कर का अनुभव बढ़ना असामान्य नहीं है, लेकिन हार न मानें।`',
        'Tamil':'3.: `தலை 45 டிகிரி: \n \nநீங்கள் உட்கார்ந்திருக்கும்போது, உங்கள் தலைவை 45° இடது தோளுக்குப் பார்க்க திருப்பி, தலையை மேல்மேலும் கீழும் அசைக்கவும். முதலில் மெதுவாக, பிறகு உங்கள் சொந்த வேகத்திற்கு ஏற்ப அதிகரிக்கவும்.\n இது திறந்த கண்களுடன் செய்யவும், பிறகு மூடிய கண்களுடன் மீண்டும் செய்யவும். நீங்கள் வலது தோளுக்குப் பார்க்கும் போது மீண்டும் செய்யவும்.\n பாயிண்ட் 3:\n இந்த பயிற்சிகள் மயக்கம் உணர்வைப் பெருக்குவது புதிதல்ல, ஆனால் விலக்காதீர்கள்.',
      },
    ),
    Video(
      id: '4',
      title: '4. Eyes focus on fingers with arm outstretched',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/4_Eyes_focus_on_fingers_with_arm_outstretched.mp4',
        'Telugu': 'assets/videos/4_Eyes_focus_on_fingers_with_arm_outstretched.mp4',
        'Hindi': 'assets/videos/4_Eyes_focus_on_fingers_with_arm_outstretched.mp4',
        'Tamil': 'assets/videos/4_Eyes_focus_on_fingers_with_arm_outstretched.mp4',
      },
      captions: {
        'English': '4: `Eyes focus on finger with arm outstretched: \n \nRepeat exercises 1-3 whilst seated with an arm outstretched in front of you and holding up your index finger.\nKeep your eyes open and focused on your finger.\nPOINT 4:\nJust like a gymnast who keeps falling off a balance beam, repetitive balance exercises are performed to ultimately improve balance.`',
        'Telugu': '4: `కళ్ళు వ్రేలిపై ఫోకస్ చేయండి చేతిని ముందుకు చాపి: \n \nకూర్చుని ఉండగా, మీ చెయ్యి పూర్తిగా ముందుకు చాపి, మీ చూపు మీ వ్రేలిపై ఉంచి, వ్యాయామాలు 1-3 ను పునరావృతం చేయండి.\n కళ్ళు తెరిచి ఉండి మీ వ్రేలిపై దృష్టి పెట్టండి.\n పాయింట్ 4:\n ఎప్పటికప్పుడు సంతులనం కోల్పోతూ ఉండే జిమ్నాస్ట్ లాగా, సంతులనం పెంచడానికి పునరావృత సంతులన వ్యాయామాలు చేయబడతాయి.',
        'Hindi':'4: `हाथ फैलाकर उंगली पर नजरें केंद्रित करें: \n \nबैठे हुए, अपने हाथ को पूरी तरह से सामने फैलाएं और अपनी तर्जनी को ऊपर उठाकर, व्यायाम 1-3 को दोहराएं।\n अपनी आंखें खुली रखें और अपनी उंगली पर ध्यान केंद्रित करें।\n बिंदु 4:\n जैसे जिम्नास्ट बार-बार बैलेंस बीम से गिरते रहते हैं, वैसे ही दोहराए जाने वाले संतुलन अभ्यास अंततः संतुलन में सुधार करने के लिए किए जाते हैं।`',
        'Tamil':'4: `கண்களை விரலில் மையப்படுத்தவும், கையை நீட்டவும்: \n \nஉட்கார்ந்தபடி, உங்கள் கையை முழுவதும் நீட்டி, உங்கள் குறிகாட்டி விரலை மேலே தூக்கி, பயிற்சி 1-3 ஐ மீண்டும் செய்யுங்கள்.\n உங்கள் கண்களை திறந்துவைத்து விரலில் கவனம் செலுத்துங்கள்.\n பாயிண்ட் 4:\n எவ்வாறு ஒரு ஜிம்னாஸ்டிக்ஸ் வீரர் சமநிலையை இழந்து வலையில் விழுகிறார், அதேபோல், சமநிலையை மேம்படுத்துவதற்காக மீண்டும் மீண்டும் சமநிலைப்படுத்தும் பயிற்சிகள் செய்யப்படுகின்றன.`',
      },
    ),
    Video(
      id: '5',
      title: '5. Standing exercise',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/5_Standing_exercise.mp4',
        'Telugu': 'assets/videos/5_Standing_exercise.mp4',
        'Hindi': 'assets/videos/5_Standing_exercise.mp4',
        'Tamil': 'assets/videos/5_Standing_exercise.mp4',
      },
      captions: {
        'English': '5: `Standing exercise: \n \nRepeat previous exercises 1-4 whilst standing up.\nDo this with eyes open, then repeat with eyes closed.\nPOINT 5:\nThe human balance system is composed of 3 different systems working together:\n1)Eyes provide visual cues\n2)The inner ear balance system provides gyroscopic information\n3)Proprioception provides a sense of position in space based on information provided from the muscles, tendons and joints.',
        'Telugu': '5: `నిలబడి చేసే వ్యాయామం: \n \nఉన్నచోట నిలబడి ఉండగా, ముందుమాటగా చెప్పిన 1-4 వ్యాయామాలను పునరావృతం చేయండి.\n కళ్ళు తెరిచి చేయండి, తరువాత కళ్ళు మూసి పునరావృతం చేయండి.\n పాయింట్ 5:\n మానవ సంతులనం వ్యవస్థ మూడు వేర్వేరు వ్యవస్థలు కలిసి పనిచేసే విధంగా రూపొందించబడి ఉంటుంది:\n1) కళ్ళు వీక్షణ సూచనలు అందిస్తాయి\n2) లోపలి చెవి సంతులనం వ్యవస్థ గిరోత్క్రమ సమాచారాన్ని అందిస్తుంది\n3) పశ్చాత్తాపం కండరాలు, తంతులు మరియు సन्धుల నుండి వచ్చిన సమాచారం ఆధారంగా స్థలంలో స్థానం యొక్క భావాన్ని అందిస్తుంది.`',
        'Hindi':'5: `खड़े होकर व्यायाम: \n \nखड़े होकर पहले बताए गए 1-4 व्यायामों को दोहराएं।\n इसे खुली आंखों से करें, फिर आंखें बंद करके दोहराएं।\n बिंदु 5:\n मानव संतुलन प्रणाली तीन अलग-अलग प्रणालियों के साथ मिलकर काम करने से बनती है:\n1) आंखें दृश्य संकेत प्रदान करती हैं\n2) आंतरिक कान संतुलन प्रणाली जाइरोस्कोपिक जानकारी प्रदान करती है\n3) प्रोप्रियोसेप्शन मांसपेशियों, टेंडन और जोड़ों से प्राप्त जानकारी के आधार पर अंतरिक्ष में स्थिति की समझ प्रदान करती है।`',
        'Tamil':'5: `நின்றபடி செய்யும் பயிற்சி: \n \nநின்றபடி, முந்தைய பயிற்சிகளை 1-4 முறை மீண்டும் செய்யவும்.\n கண்களை திறந்து செய்து, பின்னர் கண்களை மூடி மீண்டும் செய்யவும்.\n பாயிண்ட் 5:\n மனித சமநிலைக் கருவி மூன்று வேறுபட்ட அமைப்புகள் ஒன்றாகச் சேர்ந்து செயல்படுகின்றன:\n1)கண்கள் பார்வை வழியாக குறிப்புகளை வழங்குகின்றன\n2)உள் காதில் உள்ள சமநிலை அமைப்பு சுற்றுநிலைக் தகவலை வழங்குகிறது\n3)ப்ரோப்ரியோசெப்ஷன் எலும்புகள், நரம்புகள் மற்றும் மூட்டுகளிலிருந்து கிடைக்கும் தகவல்களின் அடிப்படையில் இடத்தில் அமைப்பின் உணர்வை வழங்குகிறது.`',
      },
    ),
    Video(
      id: '6',
      title: '6. Sitting up & down',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/6_Sitting_up_and_down.mp4',
        'Telugu': 'assets/videos/6_Sitting_up_and_down.mp4',
        'Hindi': 'assets/videos/6_Sitting_up_and_down.mp4',
        'Tamil': 'assets/videos/6_Sitting_up_and_down.mp4',
      },
      captions: {
        'English': '6: `Sitting up and down: \n \nRepeat previous exercises 1-4 whilst standing up and sitting down on chair.\nDo this with eyes open, then repeat with eyes closed.\nPOINT 6:\n1)Dysfunction of vision, inner ear balance, OR proprioception will result in dizziness. That is why people tend to stumble in the dark (visual loss).\n2)Spinning vertigo occurs when suddenly stopping after twirling the body like a top (temporary inner ear balance dysfunction). People tend to stumble when walking heel- to-toe with arms down (loss of proprioception). Thats why tight rope walking is hard.`',
        'Telugu': '6: `కూర్చుని పైకి దిగిపోవడం: \n \nనిల్చుని, కుర్చీలో కూర్చుని, ముందు చెప్పిన 1-4 వ్యాయామాలను పునరావృతం చేయండి.\n కళ్ళు తెరిచి చేయండి, తరువాత కళ్ళు మూసి పునరావృతం చేయండి.\n పాయింట్ 6:\n 1) కంటి చూపు, లోపలి చెవి సంతులనం లేదా ప్రోప్రియోసెప్షన్ లోపం వల్ల తలనొప్పి కలుగుతుంది. అందుకే చీకటిలో మనుషులు తొట్రిల్లడం ఎక్కువగా జరుగుతుంది (కంటి చూపు నష్టం).\n 2) శరీరం స్పిన్నింగ్ చేసి ఒక్కసారిగా ఆగినప్పుడు తల తిరగడం జరుగుతుంది (తాత్కాలిక లోపలి చెవి సంతులనం లోపం). కాళ్ళను కలిసి, చేతులు క్రింద ఉంచుకుని నడిస్తే తొట్రిల్లే అవకాశం ఉంది (ప్రోప్రియోసెప్షన్ లోపం). అందుకే చుట్టుకొలత నడక చాలా కష్టంగా ఉంటుంది.`',
        'Hindi':'6: `बैठना और उठना: \n \nपहले बताए गए 1-4 व्यायामों को खड़े होकर और कुर्सी पर बैठकर दोहराएं।\n इसे आंखें खोलकर करें, फिर आंखें बंद करके दोहराएं।\n बिंदु 6:\n 1) दृष्टि, आंतरिक कान संतुलन, या प्रोप्रियोसेप्शन का असंतुलन चक्कर आना का कारण बनता है। इसीलिए लोग अंधेरे में ठोकर खाते हैं (दृष्टि हानि)।\n 2) जब अचानक शरीर को घुमाकर रोक दिया जाता है तो घूमने वाला चक्कर आता है (अस्थायी आंतरिक कान संतुलन का असंतुलन)। लोग एड़ी से पंजे तक चलने के दौरान ठोकर खाते हैं, जब हाथ नीचे होते हैं (प्रोप्रियोसेप्शन की हानि)। इसलिए तंग रस्सी पर चलना कठिन होता है।`',
        'Tamil':'6: `உக்கிரம் எடுத்து உட்கார்ந்து எழுதல்: \n \nநின்றபடி, நாற்காலியில் உட்கார்ந்து, முந்தைய 1-4 பயிற்சிகளை மீண்டும் செய்யவும்.\n கண்களை திறந்து செய்யவும், பிறகு கண்களை மூடி மீண்டும் செய்யவும்.\n பாயிண்ட் 6:\n 1) காட்சி குறைபாடு, உள் காதில் உள்ள சமநிலையின் குறைபாடு அல்லது ப்ரோப்ரியோசெப்ஷன் குறைபாடு இருந்தால் தலைச் சுழற்சி ஏற்படும். அதனால் தான் இருளில் மனிதர்கள் தடுமாறுகிறார்கள் (காட்சி இழப்பு).\n 2) உடலைத் திருப்பி திடீரென நிறுத்தியதும் சுழல் தலைவலி ஏற்படுகிறது (தற்காலிகமாக உள்ள காதின் சமநிலையின் குறைபாடு). கால் முதல் கால் வைத்து, கைகளை கீழே விட்டு நடக்கும் போது மந்திக்கத் தொடங்குவார்கள் (ப்ரோப்ரியோசெப்ஷன் இழப்பு). அதனால் தான் சுருக்கமான கயிறு நடை கடினம்.`',
      },
    ),
    Video(
      id: '7',
      title: '7. Walking on flat surface',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/7_Walking_on_flat_surface.mp4',
        'Telugu': 'assets/videos/7_Walking_on_flat_surface.mp4',
        'Hindi': 'assets/videos/7_Walking_on_flat_surface.mp4',
        'Tamil': 'assets/videos/7_Walking_on_flat_surface.mp4',
      },
      captions: {
        'English': '7: `Walking on a flat surface: \n \nOn a flat surface, walk 10-15 steps with eyes open, then turn around and walk back 10-15 steps with eyes closed.\nRepeat the above whilst tilting your head up/down and left/right in random movement.\nFor your safety it is recommended someone else observes you when doing this exercise, preferably walking beside you in case you fall.\nPOINT 7:\nWhat this exercise is trying to accomplish is to challenge, and thereby improve, the inner ear balance system in a gradual fashion by slowly taking away balance information provided by the eyes (by closing them) as well as the proprioception (walking heel-to-toe with arms down by side.`',
        'Telugu': '7: `సమతల మైదానంలో నడవడం: \n \nసమతల మైదానంలో, కళ్ళు తెరిచి 10-15 అడుగులు నడవండి, తరువాత తిరిగి 10-15 అడుగులు కళ్ళు మూసుకుని నడవండి.\n మీ తలను ఎటువంటి క్రమం లేకుండా పైకి/కిందికి, ఎడమ/కుడి వైపు తిప్పుతూ పైన చెప్పినవాటిని పునరావృతం చేయండి.\n ఈ వ్యాయామం చేసే సమయంలో మీ భద్రత కోసం, మీరు పడిపోతే మిమ్మల్ని ఆదుకోవడానికి మరొకరు గమనించడం మంచిది, అవశ్యంగా మీ పక్కనే నడవడం ఉత్తమం.\n పాయింట్ 7:\n ఈ వ్యాయామం చేయడం ద్వారా, క్రమంగా లోపలి చెవి సంతులనం వ్యవస్థను మెరుగుపరచడం లక్ష్యం, కళ్ళు మూసుకోవడం ద్వారా దృశ్య సమాచారాన్ని తీసివేయడం మరియు పక్కవైపున చేతులు ఉంచుకొని, కాళ్లతో కాలి చిటికెలో నుంచి పాదం వరకు నడవడం ద్వారా ప్రోప్రియోసెప్షన్ సమాచారాన్ని తగ్గించడం ద్వారా మెరుగుదల కోసం ప్రయత్నించడం.`',
        'Hindi':'7: `सपाट सतह पर चलना: \n \nएक सपाट सतह पर, आँखें खोलकर 10-15 कदम चलें, फिर मुड़कर आँखें बंद करके 10-15 कदम वापस चलें।\n अपने सिर को ऊपर/नीचे और बाएँ/दाएँ बेतरतीब ढंग से हिलाते हुए ऊपर दिए गए व्यायाम को दोहराएं।\n आपकी सुरक्षा के लिए, अनुशंसा की जाती है कि कोई और व्यक्ति आपको यह व्यायाम करते समय देखे, विशेष रूप से आपके साथ चले ताकि आप गिर न जाएं।\n बिंदु 7:\n इस व्यायाम का उद्देश्य आंतरिक कान संतुलन प्रणाली को धीरे-धीरे बेहतर बनाने के लिए चुनौती देना है, जो धीरे-धीरे आंखों से प्राप्त संतुलन जानकारी को हटाकर (आंखें बंद करके) और प्रोप्रियोसेप्शन को कम करके (पंजे से एड़ी तक चलकर, हाथों को बगल में रखते हुए) किया जाता है।`',
        'Tamil':'7: `தட்டையான தரையில் நடப்பது: \n \nதட்டையான தரையில், கண்களைத் திறந்து 10-15 அடிகள் நடக்கவும், பின்னர் திரும்பி 10-15 அடிகள் கண்களை மூடிக்கொண்டு நடக்கவும்.\n உங்கள் தலையை மேலே/கீழே மற்றும் இடது/வலது பக்கமாக சீரற்ற இயக்கத்தில் சாய்த்து மேலே உள்ளதை மீண்டும் செய்யவும்.\n இந்த பயிற்சியைச் செய்யும்போது உங்கள் பாதுகாப்புக்காக, உங்கள் அருகில் யாராவது இருந்தால் நல்லது, குறிப்பாக நீங்கள் விழுந்தால் உதவுவதற்காக உங்களுடன் நடப்பது.\n பாயிண்ட் 7:\n இந்த பயிற்சியின் நோக்கம், கண்களை மூடுவதன் மூலம் (இவற்றின் தகவலைக் குறைத்து) மற்றும் கைகள் கீழே இருக்கும் போது கால் முதல் கால் வரை நடப்பதன் மூலம் மெதுவாக சென்று காது சமநிலையை மேம்படுத்துவதற்கான ஒரு சவாலாக செயல்படுவது.`',
      },
    ),
    Video(
      id: '8',
      title: '8. Walking on uneven surface',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/8_Walking_on_uneven_surface.mp4',
        'Telugu': 'assets/videos/8_Walking_on_uneven_surface.mp4',
        'Hindi': 'assets/videos/8_Walking_on_uneven_surface.mp4',
        'Tamil': 'assets/videos/8_Walking_on_uneven_surface.mp4',
      },
      captions: {
        'English': '8: `Walking on an uneven surface: \n \nRepeat exercise 7 whilst walking on pillows or blankets to create an uneven surface.\nDo this with eyes open, then repeat with eyes closed.\nDo this exercise when someone else is with you.\nPOINT 8:\nRefer to tip for exercise 7.`',
        'Telugu': '8: `అసమతల మైదానంలో నడవడం: \n \nసమతలమైన ఉపరితలాన్ని pillows లేదా దుప్పట్లు వంటి వాటి మీద నడవడం ద్వారా అసమతల ఉపరితలాన్ని సృష్టించి వ్యాయామం 7ను పునరావృతం చేయండి.\n కళ్ళు తెరిచి ఇది చేయండి, తరువాత కళ్ళు మూసుకుని మరల అదే చేయండి.\n ఎవరైనా మీతో ఉన్నప్పుడు ఈ వ్యాయామం చేయండి.\n పాయింట్ 8:\n వ్యాయామం 7కి సంబంధించిన సూచనను చూడండి.`',
        'Hindi':'8: `असमतल सतह पर चलना: \n \nपिलो या कंबल पर चलकर असमतल सतह बनाते हुए व्यायाम 7 को दोहराएं।\n इसे आँखें खोलकर करें, फिर आँखें बंद करके दोहराएं।\n यह व्यायाम तब करें जब कोई और व्यक्ति आपके साथ हो।\n बिंदु 8:\n व्यायाम 7 के लिए दी गई टिप देखें।`',
        'Tamil':'8: `ஒசிவான தரையில் நடப்பது: \n \nபிளேன்கள் அல்லது பிளாங்கெட்களை வைத்து ஒசிவான தரையை உருவாக்கி, பயிற்சி 7 ஐ மீண்டும் செய்யவும்.\n கண்களை திறந்து இதைச் செய்யவும், பின்னர் கண்களை மூடிக் கொண்டு மீண்டும் செய்யவும்.\n யாராவது உங்களுடன் இருக்கும் போது இந்த பயிற்சியைச் செய்யவும்.\n பாயிண்ட் 8:\n பயிற்சி 7 இற்கான குறிப்பைக் குறிப்பிடவும்.`',
      },
    ),
    Video(
      id: '9',
      title: '9. Walking heel to toe',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/9_Walking_heel_to_toe.mp4',
        'Telugu': 'assets/videos/9_Walking_heel_to_toe.mp4',
        'Hindi': 'assets/videos/9_Walking_heel_to_toe.mp4',
        'Tamil': 'assets/videos/9_Walking_heel_to_toe.mp4',
      },
      captions: {
        'English': '9: `Walking heel-to-toe: \n \nRepeat exercise 7 whilst walking heel-to-toe in a straight line.\nDo this with eyes open, then repeat with eyes closed.\nDo this exercise when someone else is with you.\nPOINT 9:\nRefer to tip for exercise 7.`',
        'Telugu': '9: `గోళం నుండి గోళం వరకు నడవడం: \n \nసరళ రేఖలో గోళం నుండి గోళం వరకు నడవడం ద్వారా వ్యాయామం 7 ను పునరావృతం చేయండి.\n కళ్ళు తెరిచి ఇది చేయండి, తరువాత కళ్ళు మూసుకుని మరల అదే చేయండి.\n ఎవరైనా మీతో ఉన్నప్పుడు ఈ వ్యాయామం చేయండి.\n పాయింట్ 9:\n వ్యాయామం 7కి సంబంధించిన సూచనను చూడండి.`',
        'Hindi':'9: `एड़ी से पैर की उंगलियों तक चलना: \n \nएड़ी से पैर की उंगलियों तक सीधी रेखा में चलते हुए व्यायाम 7 को दोहराएं।\n इसे आँखें खोलकर करें, फिर आँखें बंद करके दोहराएं।\n यह व्यायाम तब करें जब कोई और व्यक्ति आपके साथ हो।\n बिंदु 9:\n व्यायाम 7 के लिए दी गई टिप देखें।`',
        'Tamil':'9: `முட்டி முதல் விரல்வரை நடப்பது: \n \nஒரு நேர்படுத்தல் கோட்டில், முட்டி முதல் விரல்வரை நடப்பதைச் செய்து பயிற்சி 7 ஐ மீண்டும் செய்யவும்.\n கண்களை திறந்து இதைச் செய்யவும், பின்னர் கண்களை மூடிக் கொண்டு மீண்டும் செய்யவும்.\n யாராவது உங்களுடன் இருக்கும் போது இந்த பயிற்சியைச் செய்யவும்.\n பாயிண்ட் 9:\n பயிற்சி 7 இற்கான குறிப்பைக் குறிப்பிடவும்.`',
      },
    ),
    Video(
      id: '10',
      title: '10. Sit & lean exercise',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/10_Sit_and_lean_exercise.mp4',
        'Telugu': 'assets/videos/10_Sit_and_lean_exercise.mp4',
        'Hindi': 'assets/videos/10_Sit_and_lean_exercise.mp4',
        'Tamil': 'assets/videos/10_Sit_and_lean_exercise.mp4',
      },
      captions: {
        'English': '10: `Sit and lean exercise: \n \nSit on the edge of your sofa or bed. Begin by turning your head to the (right / left) and falling to the other side. You should be looking toward the ceiling. Hold this position until any dizziness subsides. Return to the sitting position, face forward until any dizziness subsides.\nRepeat the exercise two times to both sides with eyes open and two times to both sides with eyes closed. Repeat this exercise twice a day.\nPOINT 10:\nRepeat this exercise two times to both sides with eyes open and eyes closed and 2 times per day.`',
        'Telugu': '10: `కూర్చోవడం మరియు వంగడం వ్యాయామం: \n \nమీ సోఫా లేదా మంచం అంచున కూర్చోండి. మొదట మీ తలను (కుడి / ఎడమ) వైపుకు తిప్పి, ఇతర వైపుకు వంగండి. మీరు వానానికి చూస్తున్నట్లుగా ఉండాలి. ఏదైనా తలనొప్పి తగ్గేవరకు ఈ స్థితిని పట్టుకోండి. కూర్చునే స్థితికి తిరిగి వచ్చి, తలనొప్పి తగ్గేవరకు ముందుకు చూడు.\n కళ్ళు తెరిచి రెండు సార్లు, కళ్ళు మూసుకుని రెండు సార్లు రెండు వైపులా ఈ వ్యాయామాన్ని పునరావృతం చేయండి. ఈ వ్యాయామాన్ని రోజుకు రెండు సార్లు చేయండి.\n పాయింట్ 10:\n ఈ వ్యాయామాన్ని రెండు సార్లు కళ్ళు తెరిచి మరియు కళ్ళు మూసుకుని రెండుసార్లు ప్రతిరోజూ చేయండి.`',
        'Hindi':'10: `बैठने और झुकने का व्यायाम: \n \nअपने सोफे या बिस्तर के किनारे बैठें। सबसे पहले अपना सिर (दाएं/बाएं) घुमाएं और दूसरी तरफ गिरें। आपको छत की ओर देखना चाहिए। जब तक चक्कर आना कम न हो जाए, इस स्थिति को बनाए रखें। फिर से बैठने की स्थिति में लौटें और जब तक चक्कर आना कम न हो जाए, सीधे आगे देखें।\n आँखें खुली रखते हुए दोनों ओर दो बार व्यायाम करें, फिर आँखें बंद करके दोनों ओर दो बार करें। इस व्यायाम को दिन में दो बार करें।\n बिंदु 10:\n इस व्यायाम को आँखें खुली और बंद करके दोनों ओर दो बार और दिन में दो बार करें।`',
        'Tamil':'10: `உட்கார்ந்து சாயும் பயிற்சி: \n \nஉங்கள் சோபா அல்லது படுக்கையின் ஓரத்தில் உட்காரவும். முதலில் உங்கள் தலைவை (வலது / இடது) திருப்பி, மற்றொரு பக்கமாக விழுங்கள். நீங்கள் வானத்தை நோக்கி இருக்க வேண்டும். மயக்கம் குறையும் வரை இந்த நிலையைத் தக்கவைத்துக் கொள்ளவும். உட்காரும் நிலைக்கு திரும்பி, மயக்கம் குறையும் வரை நேராக பாருங்கள்.\n கண்களைத் திறந்து இரு பக்கங்களுக்கும் இருமுறை, கண்களை மூடி இரு பக்கங்களுக்கும் இருமுறை இந்தப் பயிற்சியை மேற்கொள்ளவும். இந்த பயிற்சியை தினமும் இருமுறை செய்யவும்.\n பாயிண்ட் 10:\n கண்களைத் திறந்து இருமுறை, கண்களை மூடி இருமுறை, தினமும் இருமுறை இந்தப் பயிற்சியைச் செய்யவும்.`',
      },
    ),
    Video(
      id: '11',
      title: '11. Rolling exercise',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/11_Rolling_exercise.mp4',
        'Telugu': 'assets/videos/11_Rolling_exercise.mp4',
        'Hindi': 'assets/videos/11_Rolling_exercise.mp4',
        'Tamil': 'assets/videos/11_Rolling_exercise.mp4',
      },
      captions: {
        'English': '11: `Rolling exercise: \n \nPractise rolling slowly from your back to your (right side / left side / both sides).\nDo this with your eyes open first, then with eyes closed. Hold each position until any dizziness subsides. As you improve try to move more quickly.\nRepeat these movements for 10 repetitions, twice a day.\nPOINT 11:\nRepeat these movements for 10 repetitions, twice a day.`',
        'Telugu': '11: `రోలింగ్ వ్యాయామం: \n \nమెల్లగా మీ వెనుక నుంచి మీ (కుడి వైపు / ఎడమ వైపు / రెండు వైపులా) రోల్ చేయడం ప్రాక్టీస్ చేయండి.\n మొదట మీ కళ్ళు తెరిచి చేయండి, తరువాత కళ్ళు మూసుకుని చేయండి. ఏదైనా తలనొప్పి తగ్గేవరకు ప్రతి స్థితిని పట్టుకోండి. మీరు మెరుగుపడినప్పుడు మరింత వేగంగా కదలడానికి ప్రయత్నించండి.\n ఈ కదలికలను 10 సార్లు, రోజుకు రెండు సార్లు పునరావృతం చేయండి.\n పాయింట్ 11:\n ఈ కదలికలను 10 సార్లు, రోజుకు రెండు సార్లు పునరావృతం చేయండి.`',
        'Hindi':'11: `रोलिंग व्यायाम: \n \nधीरे-धीरे अपनी पीठ से (दाईं ओर / बाईं ओर / दोनों ओर) रोल करने का अभ्यास करें।\n पहले अपनी आँखें खुली रखें, फिर आँखें बंद करके करें। जब तक चक्कर आना कम न हो जाए, हर स्थिति को बनाए रखें। जैसे-जैसे आप सुधार करेंगे, तेजी से घूमने की कोशिश करें।\n इन आंदोलनों को 10 बार, दिन में दो बार दोहराएं।\n बिंदु 11:\n इन आंदोलनों को 10 बार, दिन में दो बार दोहराएं।`',
        'Tamil':'11: `உருண்டு பயிற்சி: \n \nஉங்கள் முதுகில் இருந்து மெதுவாக (வலது பக்கம் / இடது பக்கம் / இரண்டு பக்கங்களிலும்) உருளுங்கள்.\n முதலில் உங்கள் கண்களைத் திறந்து இதைச் செய்யவும், பின்னர் கண்களை மூடி செய்யவும். மயக்கம் குறையும் வரை ஒவ்வொரு நிலையிலும் தங்குங்கள். நீங்கள் மேம்பட்ட பிறகு வேகமாக நகர முயற்சி செய்யுங்கள்.\n இந்த இயக்கங்களை 10 முறை, தினமும் இருமுறை செய்யுங்கள்.\n பாயிண்ட் 11:\n இந்த இயக்கங்களை 10 முறை, தினமும் இருமுறை செய்யுங்கள்.`',
      },
    ),
    Video(
      id: '12',
      title: '12. Brandt-daroff exercise',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/12_Brandt_daroff_exercise.mp4',
        'Telugu': 'assets/videos/12_Brandt_daroff_exercise.mp4',
        'Hindi': 'assets/videos/12_Brandt_daroff_exercise.mp4',
        'Tamil': 'assets/videos/12_Brandt_daroff_exercise.mp4',
      },
      captions: {
        'English': '12: `Brandt-Daroff Exercises: \n \nVestibular therapy exercise used to reduce vertigo symptoms.\n• Easy enough to complete at home.\n• Requires ability to lie flat, flex and turn the neck, and roll onto the right and left shoulders.\n• May cause vertigo, sweating, nausea, and vomiting.\nProcees to do\n1)Turn head and lie on opposite side\n2)Hold position for 30 seconds or until vertigo is gone\n3)Repeat maneuver to the opposite side\n4)Maintain the position for 30 seconds or until any vertigo subsides`',
        'Telugu': '12: `Brandt-Daroff వ్యాయామాలు: \n \nతలనొప్పి లక్షణాలను తగ్గించడానికి ఉపయోగించే వెస్టిబ్యులర్ థెరపీ వ్యాయామం.\n• ఇంట్లో సులభంగా పూర్తిచేయడానికి సరిపోతుంది.\n• నేరుగా పడుకోవడం, మెడను వంచడం మరియు కుడి మరియు ఎడమ భుజాలపై పడుకోవడం చేయగల సామర్థ్యం అవసరం.\n• ఈ వ్యాయామం తలనొప్పి, చెమట పట్టడం, వాంతి మరియు కడుపు నొప్పిని కలిగించవచ్చు.\nక్రియాచరణ:\n1) తల తిప్పి ఎదురుగా ఉన్న వైపుకు పడుకోండి\n2) తలనొప్పి తగ్గేవరకు లేదా 30 సెకన్ల పాటు స్థితిని కొనసాగించండి\n3) వ్యాయామాన్ని వ్యతిరేక వైపుకు పునరావృతం చేయండి\n4) తలనొప్పి తగ్గేవరకు లేదా 30 సెకన్ల పాటు స్థితిని కొనసాగించండి`',
        'Hindi':'12: `ब्रांड्ट-डारॉफ व्यायाम: \n \nचक्कर आने के लक्षणों को कम करने के लिए वेस्टिबुलर थेरेपी व्यायाम।\n• इसे घर पर आसानी से पूरा किया जा सकता है।\n• सीधे लेटने, गर्दन को मोड़ने और दाएँ-बाएँ कंधों पर लुढ़कने की क्षमता की आवश्यकता होती है।\n• यह चक्कर आना, पसीना आना, मतली और उल्टी का कारण बन सकता है।\nप्रक्रिया:\n1) सिर को घुमाकर विपरीत दिशा में लेटें\n2) 30 सेकंड तक स्थिति बनाए रखें या जब तक चक्कर आना बंद न हो जाए\n3) विपरीत दिशा में इस क्रिया को दोहराएं\n4) 30 सेकंड तक स्थिति बनाए रखें या जब तक चक्कर आना बंद न हो जाए`',
        'Tamil':'12: `Brandt-Daroff பயிற்சிகள்: \n \nமயக்கத்தை குறைக்க உதவும் காது சமநிலைத் தீர்வு பயிற்சி.\n• வீட்டில் சுலபமாக முடிக்கலாம்.\n• நேராக படுத்து, கழுத்தை வளைத்து திருப்பி, வலது மற்றும் இடது தோள்களில் சாய்வதற்கான திறன் தேவைப்படுகிறது.\n• இந்த பயிற்சிகள் மயக்கம், வியர்வை, குமட்டல் மற்றும் வாந்தியை உண்டாக்கலாம்.\nசெய்யும் முறை:\n1) தலை திருப்பி எதிர்ப்புறம் படுக்கவும்\n2) மயக்கம் மறையும்வரை அல்லது 30 விநாடிகள் நிலையைத் தொடரவும்\n3) இந்த செயலியை மாறாகவும் செய்யவும்\n4) மயக்கம் மறையும்வரை அல்லது 30 விநாடிகள் நிலையைத் தொடரவும்`',
      },
    ),
    Video(
      id: '13',
      title: '13. Elf-epley maneuver right ear exercise',
      imagePath: 'assets/video1.png',
      languages: ['English', 'Telugu', 'Hindi', 'Tamil'],
      uris: {
        'English': 'assets/videos/13_Elf_epley_maneuver_right_ear_exercise.mp4',
        'Telugu': 'assets/videos/13_Elf_epley_maneuver_right_ear_exercise.mp4',
        'Hindi': 'assets/videos/13_Elf_epley_maneuver_right_ear_exercise.mp4',
        'Tamil': 'assets/videos/13_Elf_epley_maneuver_right_ear_exercise.mp4',
      },
      captions: {
        'English': '13: `Elf-epley maneuver right ear exercise\nSteps\n1. Preparation: \nSit upright on a bed or flat surface with your legs extended in front of you.Place a pillow behind you for support.\n2. Head Rotation: \nTurn your head 45 degrees to the right, keeping your eyes fixed on a point in front of you.Hold this position for a few moments to allow any dizziness to subside.\n3. Lying Down: \nQuickly lie back on the bed, keeping your head turned to the right and your neck extended over the edge of the bed.Allow your head to hang slightly off the edge of the bed.\n4. Head Rotation (Continued): \nMaintain the 45-degree head rotation to the right.Hold this position for about 30 seconds or until any spinning sensations resolve.\n5. Return to Sitting Position:\nSlowly and carefully sit back up, keeping your head turned to the right.Take a few moments to rest and allow any remaining dizziness to dissipate.\n6. Repeat if Necessary: \nIf symptoms persist, you may repeat the maneuver up to three times to ensure the crystals are properly repositioned`',
        'Telugu': '13: `ఎల్ఫ్-ఎప్లే మాన్యువర్ కుడి చెవికి వ్యాయామం\nప్రక్రియలు\n1. సిద్ధం కావడం: \nమీ కాళ్ళు మీ ముందుగా విస్తరించి పడక లేదా సమతలమైన ఉపరితలంపై నెట్టుకొనండి. మద్దతు కోసం మీ వెనుక ఒక దిండు ఉంచండి.\n2. తల తిప్పడం: \nమీరు ఎదురుగా ఉన్న పాయింట్‌పై దృష్టి నిలుపుకుంటూ మీ తలని కుడి వైపుకు 45 డిగ్రీలు తిప్పండి. తలనొప్పి తగ్గడానికి కొంత సమయం ఈ స్థితిలో ఉంచండి.\n3. పడుకోవడం: \nమీ తల కుడి వైపుకు తిప్పి, మీ కాలు బెడ్డు చివరికి పొడగిస్తూ త్వరగా బెడ్తో పడుకోండి. మీ తల కొంచెం బెడ్టు నుంచి వేలాడదీయండి.\n4. తల తిప్పడం (కొనసాగింపు): \nకుడి వైపుకు 45 డిగ్రీల తల తిప్పడం కొనసాగించండి. ఈ స్థితిని 30 సెకండ్లు లేదా మలుపు భావనలు తొలగించబడే వరకు ఉంచండి.\n5. కూర్చోని స్థితికి తిరిగి రావడం: \nమీ తల కుడి వైపుకు తిప్పినట్లు అంగీకరించి, క్రమంగా మరియు జాగ్రత్తగా కూర్చొండి. కొన్ని క్షణాలు విశ్రాంతి తీసుకోండి మరియు మిగతా తలనొప్పి తగ్గడానికి అవకాశం ఇవ్వండి.\n6. అవసరమైతే పునరావృతం చేయండి: \nలక్షణాలు కొనసాగితే, క్రిస్టల్స్ సరిగ్గా పునరుద్ధరించబడినట్లయితే, మీరు మాన్యువర్‌ను మూడు సార్లు పునరావృతం చేయవచ్చు.`',
        'Hindi':'13: `एल्फ-एप्ले प्रक्रिया दाहिने कान के लिए व्यायाम\nकदम\n1. तैयारी: \nअपने पैरों को अपने सामने फैला कर बिस्तर या समतल सतह पर सीधे बैठें। समर्थन के लिए अपने पीछे एक तकिया रखें।\n2. सिर की घुमाव: \nअपने सामने एक बिंदु पर ध्यान केंद्रित करते हुए, अपने सिर को दाईं ओर 45 डिग्री घुमाएं। किसी भी चक्कर को कम करने के लिए इस स्थिति को कुछ क्षणों तक बनाए रखें।\n3. लेटना: \nतेजी से बिस्तर पर लेटें, अपने सिर को दाईं ओर घुमाते हुए और गर्दन को बिस्तर के किनारे से बाहर लटकाते हुए। अपने सिर को बिस्तर के किनारे से थोड़ा लटकने दें।\n4. सिर की घुमाव (जारी): \nदाईं ओर 45 डिग्री की सिर की घुमाव बनाए रखें। इस स्थिति को लगभग 30 सेकंड तक या जब तक घूमने का अनुभव समाप्त न हो जाए, बनाए रखें।\n5. बैठने की स्थिति में लौटना: \nधीरे और सावधानी से बैठें, अपने सिर को दाईं ओर घुमाते हुए। आराम करने के लिए कुछ क्षण लें और किसी भी शेष चक्कर को खत्म करने का अवसर दें।\n6. आवश्यक होने पर दोहराएं: \nयदि लक्षण जारी रहते हैं, तो सुनिश्चित करें कि क्रिस्टल सही स्थिति में हैं, आप इस प्रक्रिया को तीन बार दोहरा सकते हैं।`',
        'Tamil':'13: `எல்ஃப்-எப்லே மேனுவர் வலது காது பயிற்சி\nஅடிகள்\n1. தயாரிப்பு: \nஉங்கள் கால்களை முன்னிலையில் விரித்துக்கொண்டு படுக்கையில் அல்லது சமமான மேற்பரப்பில் நேராக உட்காரவும். ஆதரவு அளிக்க உங்கள் பின்னணியில் ஒரு கம்பளை வைக்கவும்.\n2. தலை திருப்புதல்: \nஉங்கள் முன்னிலையில் உள்ள புள்ளிக்கு கவனம் செலுத்தி உங்கள் தலையை வலது பக்கம் 45 டிகிரி திருப்பவும். மயக்கம் நீங்க காத்திருப்பதற்காக இந்த நிலையில் சில நேரம் வைத்திருக்கவும்.\n3. படுத்தல்: \nஉங்கள் தலை வலது பக்கம் திருப்பியபின், விரைவாக படுக்கையில் படுக்கவும், உங்கள் கழுத்து படுக்கையின் வலது தோலுக்கு நீட்டிக்கப்பட வேண்டும். உங்கள் தலை சிறிது படுக்கையின் முடியை மிதவிடுங்கள்.\n4. தலை திருப்புதல் (தொடக்கம்): \nவலது பக்கம் 45 டிகிரி தலை திருப்பத்தை தொடரவும். இந்த நிலையில் சுமார் 30 விநாடிகள் அல்லது மயக்கம் நீங்கும்வரை நீட்டிக்கவும்.\n5. உட்கார்வதற்குப் பின்னர்: \nதலை வலது பக்கம் திருப்பியபடி மெதுவாகவும் கவனமாகவும் உட்காரவும். சில நேரம் ஓய்வுக்கு செல்கவும் மற்றும் மீதமுள்ள மயக்கம் நீங்கக் காத்திருக்கவும்.\n6. தேவையானால் மீண்டும் செய்க: \nஎப்படி இருந்தாலும், மூன்று முறை மீண்டும் செய்யவும், குரூப்புகள் சரியான இடத்தில் இருப்பதை உறுதிப்படுத்தவும்.`,',
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFC5EDFE), // Set background color
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
            children: [
              // Back Arrow Image with Padding and Back Navigation
              Padding(
                padding: const EdgeInsets.only(top: 25.0), // Add horizontal padding
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                  child: Image.asset(
                    'assets/backarrow.png', // Replace with your actual image path
                    width: 50, // Set width as needed
                    height: 50, // Set height as needed
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between image and title
              // Explore Videos Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5, spreadRadius: 1),
                  ],
                ),
                child: Text(
                  'Explore Videos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10), // Space between title and search box
              // Search Box with white background
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  filled: true, // Fill background
                  fillColor: Colors.white, // White background for search box
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    searchQuery = text;
                  });
                },
              ),
              SizedBox(height: 10), // Space between search box and video list
              // Video List
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1, // Adjust aspect ratio to your needs
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    if (searchQuery.isNotEmpty &&
                        !video.title.toLowerCase().contains(searchQuery.toLowerCase())) {
                      return SizedBox.shrink(); // Hide item if it doesn't match search
                    }
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Navigate to video player screen with required parameters
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPage(
                                patientId: widget.patientId,
                                videoId: video.id.toString(),
                                videoTitle: video.title,
                                videoLanguages: video.languages,
                                videoUris: video.uris,
                                videoCaptions: video.captions,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(video.imagePath, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                video.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
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
        ),
      ),
    );
  }
}

class Video {
  final String id;
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