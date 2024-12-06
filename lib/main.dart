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
import 'ArticleDetails.dart';
import 'FeedbackScreen.dart';
import 'VideoPage.dart';
import 'AdminScreen.dart';
import 'AllPatientDetails.dart';
import 'PatientDetails.dart';
import 'PatientCommentsScreen.dart'; // Import the PatientCommentsScreen

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
            final args = Get.arguments as Map<String, dynamic>?; // Get the arguments
            final patientId = args?['patientId'] ?? ''; // Ensure default or handle null
            return PatientDrawerNavigator(patientId: patientId);
          },
        ),
        GetPage(
          name: '/ExploreArticles',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return ExploreArticles(patientId: args['patientId']);
          },
        ),
        GetPage(
          name: '/ExploreVideos',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return ExploreVideos(patientId: args['patientId']);
          },
        ),
        GetPage(
          name: '/DoctorDrawer',
          page: () {
            final args = Get.arguments as Map<String, dynamic>?; // Get the arguments
            final doctorId = args?['doctorId'] ?? ''; // Ensure default or handle null
            return DoctorDrawerNavigator(doctorID: doctorId);
          },
        ),
        GetPage(
          name: '/ArticleDetails',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return ArticleDetails(
              title: args['title'],
              image: args['image'],
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
              videoId: args['videoId'],
              videoTitle: args['videoTitle'],
              videoLanguages: args['videoLanguages'].cast<String>(),
              videoUris: args['videoUris'].cast<String, String>(),
              videoCaptions: args['videoCaptions'].cast<String, String>(),
            );
          },
        ),
        GetPage(
          name: '/AdminScreen',
          page: () => AdminScreen(),
        ),
        GetPage(
          name: '/AllPatientDetails',
          page: () => AllPatientDetails(),
        ),
        GetPage(
          name: '/PatientDetails',
          page: () {
            final patientId = Get.arguments as String? ?? ''; // Directly get the patientId
            return PatientDetails(patientId: patientId); // Pass patientId to PatientDetails
          },
        ),
        GetPage(
          name: '/PatientCommentsScreen',
          page: () {
            final args = Get.arguments as Map<String, dynamic>; // Get arguments as Map
            final patientId = args['patientId'] ?? ''; // Retrieve patientId from arguments
            return PatientCommentsScreen(patientId: patientId); // Pass patientId to PatientCommentsScreen
          },
        ),
      ],
    );
  }
}
