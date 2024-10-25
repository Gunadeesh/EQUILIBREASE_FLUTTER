import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equilibrease/AboutScreenPatient.dart';
import 'package:equilibrease/DoctorRepliesScreen.dart';
import 'package:equilibrease/HelpScreenPatient.dart';
import 'package:equilibrease/MyDetailsScreen.dart';
import 'package:equilibrease/PatientLogin.dart';
import 'PatientDashboard1.dart';
import 'ProfileScreenEdit.dart';
import 'DoctorPatient.dart';
import 'CustomDrawerContentPatient.dart';

class PatientDrawerNavigator extends StatelessWidget {
  final String patientId;

  const PatientDrawerNavigator({Key? key, required this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: CustomDrawerContentPatient(
            patientId: patientId,
            onLogout: () => _logout(context), // Pass logout function
          ),
        ),
        body: PatientDashboard1(patientId: patientId), // Default screen
      ),
      routes: {
        'Profile': (context) => ProfileScreenEdit(patientId: patientId),
        'MyDetailsScreen': (context) => MyDetailsScreen(patientId: patientId),
        'DoctorRepliesScreen': (context) => DoctorRepliesScreen(patientId: patientId),
        'AboutScreenPatient': (context) => AboutScreenPatient(),
        'HelpScreenPatient': (context) => HelpScreenPatient(),
        'PatientLogin': (context) => PatientLogin(), // Corrected route
      },
    );
  }

  // Logout function to clear session and navigate to login screen
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear session data

    // Navigate to PatientLogin and remove all previous routes
    Navigator.pushNamedAndRemoveUntil(context, 'PatientLogin', (route) => false);
  }
}
