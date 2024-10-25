import 'package:flutter/material.dart';

class HelpScreenPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final double windowWidth = MediaQuery.of(context).size.width;
    final double windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: Stack(
        children: [
          // Back button
          Positioned(
            top: 20,
            left: 15,
            child: IconButton(
              icon: Image.asset('assets/backarrow.png', width: 60, height: 60),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Inner container
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                width: windowWidth * 0.9, // Responsive width
                height: windowHeight * 0.85, // Responsive height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 70), // Use EdgeInsets to set top margin
                child: Column(
                  children: [
                    // Heading container
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Help.png', width: 50, height: 50),
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
                    // Horizontal line
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      height: 10,
                    ),
                    // Text container
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
