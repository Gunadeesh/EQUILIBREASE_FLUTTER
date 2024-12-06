import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AboutScreenPatient.dart';
import 'DoctorRepliesScreen.dart';
import 'HelpScreenPatient.dart';
import 'MyDetailsScreen.dart';
import 'PatientLogin.dart';
import 'PatientDashboard1.dart';
import 'ProfileScreenEdit.dart';
import 'CustomDrawerContentPatient.dart';

class PatientDrawerNavigator extends StatelessWidget {
  final String patientId;

  const PatientDrawerNavigator({Key? key, required this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerContentPatient(
        patientId: patientId,
        onNavigate: _navigateTo,
        onLogout: () => _logout(context),
      ),
      body: Navigator(
        initialRoute: '/dashboard',
        onGenerateRoute: (settings) {
          return _buildPageRoute(context, settings.name, settings.arguments);
        },
      ),
    );
  }

  MaterialPageRoute _buildPageRoute(BuildContext context, String? routeName, Object? arguments) {
    late Widget page;

    switch (routeName) {
      case '/profile':
        page = ProfileScreenEdit(patientId: patientId);
        break;
      case '/myDetails':
        page = MyDetailsScreen(patientId: patientId);
        break;
      case '/doctorReplies':
        page = DoctorRepliesScreen(patientId: patientId);
        break;
      case '/about':
        page = AboutScreenPatient();
        break;
      case '/help':
        page = HelpScreenPatient();
        break;
      case '/logout':
        return MaterialPageRoute(builder: (_) => PatientLogin());
      case '/dashboard':
      default:
        page = PatientDashboard1(patientId: patientId);
    }

    return MaterialPageRoute(builder: (_) => page);
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    // Close the drawer and navigate with a Scaffold wrapper.
    Navigator.of(Get.context!).pop();

    Widget page;
    switch (routeName) {
      case '/profile':
        page = ProfileScreenEdit(patientId: patientId);
        break;
      case '/myDetails':
        page = MyDetailsScreen(patientId: patientId);
        break;
      case '/doctorReplies':
        page = DoctorRepliesScreen(patientId: patientId);
        break;
      case '/about':
        page = AboutScreenPatient();
        break;
      case '/help':
        page = HelpScreenPatient();
        break;
      case '/dashboard':
      default:
        page = PatientDashboard1(patientId: patientId);
    }

    // Ensure the screen is wrapped in a Scaffold if needed
    Get.to(() => Scaffold(body: page));
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear session data

    Get.offAll(() => PatientLogin());
  }
}
