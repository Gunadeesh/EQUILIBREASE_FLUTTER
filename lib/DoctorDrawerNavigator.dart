import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DoctorDashboard.dart';
import 'ProfileScreen.dart';
import 'AddPatientScreen.dart';
import 'GraphScreen.dart';
import 'CustomDrawerContent.dart';
import 'AboutUsScreen.dart';
import 'HelpScreen.dart';
import 'DoctorPatient.dart';
import 'AllPatientDetails.dart';
import 'PatientDetails.dart';
import 'PatientCommentsScreen.dart';
import 'AllPatientComment.dart';
import 'QuestionReplyScreen.dart';

class DoctorDrawerNavigator extends StatelessWidget {
  final String doctorID;

  const DoctorDrawerNavigator({Key? key, required this.doctorID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerContent(
        doctorID: doctorID,
        onNavigate: _navigateTo,
      ),
      body: Navigator(
        initialRoute: '/dashboard',
        onGenerateRoute: (settings) {
          return _buildPageRoute(settings.name, settings.arguments);
        },
      ),
    );
  }

  MaterialPageRoute _buildPageRoute(String? routeName, Object? arguments) {
    late Widget page;

    switch (routeName) {
      case '/profile':
        page = ProfileScreen(doctorID: doctorID);
        break;
      case '/addPatient':
        page = AddPatientScreen(); // Pass doctorID if needed
        break;
      case '/AllPatientDetails':
        page = AllPatientDetails(); // Ensure it accepts doctorID
        break;
      case '/PatientDetails':
        final patientId = (arguments as Map<String, dynamic>?)?['patientId'] ?? ''; // Retrieve patientId from arguments
        page = PatientDetails(patientId: patientId);
        break;
      case '/PatientCommentsScreen':
        final patientId = (arguments as Map<String, dynamic>?)?['patientId'] ?? '';
        page = PatientCommentsScreen(patientId: patientId);
        break;
      case '/AllPatientComment':
        page = PatientQueriesScreen();
        break;
      case '/QuestionReplyScreen': // Route for QuestionReplyScreen
        final patient = (arguments as Map<String, dynamic>?)?['patient'];
        page = QuestionReplyScreen(patient: patient);
        break;
      case '/graph':
        page = GraphScreen();
        break;
      case '/about':
        page = AboutUsScreen();
        break;
      case '/help':
        page = HelpScreen();
        break;
      case '/logout':
        return MaterialPageRoute(builder: (_) => DoctorPatient());
      case '/dashboard':
      default:
        page = DoctorDashboard(doctorID: doctorID);
    }

    return MaterialPageRoute(builder: (_) => page);
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.of(Get.context!).pop(); // Close drawer

    switch (routeName) {
      case '/profile':
        Get.to(() => ProfileScreen(doctorID: doctorID));
        break;
      case '/addPatient':
        Get.to(() => AddPatientScreen());
        break;
      case '/AllPatientDetails':
        Get.to(() => AllPatientDetails());
        break;
      case '/PatientDetails':
        Get.to(() => PatientDetails(patientId: arguments?['patientId'] ?? ''));
        break;
      case '/PatientCommentsScreen':
        Get.to(() => PatientCommentsScreen(patientId: arguments?['patientId'] ?? ''));
        break;
      case '/AllPatientComment':
        Get.to(() => PatientQueriesScreen());
        break;
      case '/QuestionReplyScreen': // Navigate with patient argument
        Get.to(() => QuestionReplyScreen(patient: arguments?['patient']));
        break;
      case '/graph':
        Get.to(() => GraphScreen());
        break;
      case '/about':
        Get.to(() => AboutUsScreen());
        break;
      case '/help':
        Get.to(() => HelpScreen());
        break;
      case '/logout':
        Get.offAll(() => DoctorPatient());
        break;
      case '/dashboard':
      default:
        Get.to(() => DoctorDashboard(doctorID: doctorID));
    }
  }
}
