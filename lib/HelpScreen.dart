import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE), // Background color
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5), // Add left and right padding
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Go back to the previous screen
                },
                child: Image.asset(
                  'assets/backarrow.png',
                  width: 60,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9, // Responsive width
              height: MediaQuery.of(context).size.height * 0.85, // Responsive height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20), // Container padding
              margin: EdgeInsets.only(top: 70), // Set top margin here
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Help.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Help',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10), // Padding for text content
                        child: Text(
                          '1. Getting Started:\n'
                              '• How to download and install Equilibrease from the App Store or Google Play Store.\n'
                              '• Creating an account and logging in.\n'
                              '• Overview of the main features and functionalities of the app.\n\n'
                              '2. Navigating the App:\n'
                              '• Tour of the app\'s interface: home screen, navigation menu, and settings.\n'
                              '• Understanding the dashboard and how to view your vertigo episode history.\n\n'
                              '3. Recording Vertigo Episodes:\n'
                              '• How to record a new vertigo episode:\n'
                              '  • Logging the date, time, duration, and intensity of the episode.\n'
                              '  • Adding any triggers or relieving factors experienced.\n\n'
                              '4. Home Maneuvers:\n'
                              '• Accessing instructions and videos for various home maneuvers:\n'
                              '  • Epley maneuver, Brandt-Daroff exercises, and others.\n'
                              '• How to mark when you perform a maneuver and track its effectiveness.\n\n'
                              '5. Symptom Tracking and Trends:\n'
                              '• Logging daily symptoms and viewing trends over time.\n'
                              '• Understanding graphs and charts that show your symptom history.',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
