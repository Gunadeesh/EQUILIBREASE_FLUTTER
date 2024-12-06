import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;
    final double windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFC1E5FC),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, // Set status bar style
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Doctor Card
              _buildCard(
                context,
                'assets/doctor.png',
                'DOCTOR',
                windowWidth,
                windowHeight,
                    () => Navigator.pushNamed(context, '/DoctorLogin'),
              ),
              SizedBox(height: windowHeight * 0.03), // Dynamic spacing

              // Patient Card
              _buildCard(
                context,
                'assets/patient.png',
                'PATIENT',
                windowWidth,
                windowHeight,
                    () => Navigator.pushNamed(context, '/PatientLogin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String imagePath,
      String buttonText,
      double windowWidth,
      double windowHeight,
      VoidCallback onPressed,
      ) {
    return Container(
      width: windowWidth * 0.85, // Adjusted width for responsiveness
      height: windowHeight * 0.35, // Adjusted height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjusted spacing
        children: [
          Image.asset(
            imagePath,
            width: windowWidth * 0.5, // Adjusted image size
            height: windowHeight * 0.2,
            fit: BoxFit.contain,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF74B3FF),
              minimumSize: Size(windowWidth * 0.5, windowHeight * 0.06), // Adjusted button size
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: windowWidth * 0.045, // Responsive text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
