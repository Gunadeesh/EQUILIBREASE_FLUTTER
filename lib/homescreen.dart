import 'package:flutter/material.dart';
import 'package:get/get.dart'; // For navigation (install using: flutter pub add get)

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFC1E5FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header Container
            Container(
              width: width * 0.9,
              height: height * 0.5,
              decoration: BoxDecoration(
                color: const Color(0xFF74B3FF),
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/vertigologo.png',
                    width: width * 0.8,
                    height: height * 0.15,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'EQUILIBREASE APP',
                    textAlign: TextAlign.center,  // <-- Moved here
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.05),

            // Get Started Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF74B3FF),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
              ),
              onPressed: () {
                Get.toNamed('/DoctorPatient'); // Navigation to 'DoctorPatient'
              },
              child: Text(
                'GET STARTED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
