import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';
import 'DoctorPatient.dart';
import 'PatientLogin.dart';
import 'DoctorLogin.dart';
import 'PatientDrawerNavigator.dart';
import 'DoctorDrawerNavigator.dart';
import 'ExploreArticles.dart';
import 'ExploreVideos.dart';
import 'ArticleDetails.dart'; // Import your ArticleDetails screen
import 'FeedbackScreen.dart'; // Import FeedbackScreen
import 'VideoPage.dart'; // Import VideoPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/DoctorPatient', page: () => DoctorPatient()),
        GetPage(name: '/PatientLogin', page: () => PatientLogin()),
        GetPage(name: '/DoctorLogin', page: () => DoctorLogin()),
        GetPage(
          name: '/PatientDrawer',
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;
            final patientId = args?['patientId'];
            return PatientDrawerNavigator(patientId: patientId!);
          },
        ),
        GetPage(
          name: '/ExploreArticles',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            final patientId = args['patientId'];
            return ExploreArticles(patientId: patientId);
          },
        ),
        GetPage(
          name: '/ExploreVideos',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            final patientId = args['patientId'];
            return ExploreVideos(patientId: patientId);
          },
        ),
        GetPage(
          name: '/DoctorDrawer',
          page: () {
            final args = Get.arguments as Map<String, dynamic>?;
            final doctorId = args?['doctorId'];
            return DoctorDrawerNavigator(doctorID: doctorId!);
          },
        ),
        GetPage(
          name: '/ArticleDetails',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return ArticleDetails(
              title: args['title'],
              image: args['image'], // Ensure this is a valid string path
              content: args['content'],
              references: args['references'],
            );
          },
        ),
        GetPage(
          name: '/FeedbackScreen',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return FeedbackScreen(
              videoId: args['videoId'],
              patientId: args['patientId'],
            );
          },
        ),
        GetPage(
          name: '/VideoPage',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return VideoPage(
              patientId: args['patientId'],
              videoTitle: args['videoTitle'],
              videoLanguages: args['videoLanguages'].cast<String>(),
              videoUris: args['videoUris'].cast<String, String>(),
              videoCaptions: args['videoCaptions'].cast<String, String>(),
            );
          },
        ),
      ],
    );
  }
}
