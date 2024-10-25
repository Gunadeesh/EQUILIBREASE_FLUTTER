import 'package:flutter/material.dart';
import 'DoctorDashboard.dart';
/*import 'profile_screen.dart';
import 'add_patient_screen.dart';
import 'graph_screen.dart';
import 'about_us_screen.dart';
import 'help_screen.dart';
import 'doctor_patient.dart';*/
import 'CustomDrawerContent.dart';

class DoctorDrawerNavigator extends StatelessWidget {
  final String doctorID; // Receiving doctor_ID from login

  DoctorDrawerNavigator({required this.doctorID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerContent(doctorID: doctorID), // Pass doctorID to drawer
      body: Navigator(
        onGenerateRoute: (settings) {
          Widget page;

          // Handle navigation between screens
          switch (settings.name) {
            /*case '/profile':
              page = ProfileScreen(doctorID: doctorID);
              break;
            case '/add_patient':
              page = AddPatientScreen(doctorID: doctorID);
              break;
            case '/graph':
              page = GraphScreen(doctorID: doctorID);
              break;
            case '/about_us':
              page = AboutUsScreen();
              break;
            case '/help':
              page = HelpScreen();
              break;
            case '/logout':
              page = DoctorPatient(); // Log out to DoctorPatient screen
              break;*/
            default:
              page = DoctorDashboard(doctorID: doctorID); // Default to DoctorDashboard
          }

          return MaterialPageRoute(builder: (_) => page);
        },
        initialRoute: '/', // Default route
      ),
    );
  }
}
