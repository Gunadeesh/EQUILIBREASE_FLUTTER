import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the dimensions of the screen
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: Stack(
        children: [
          Positioned(
            top: windowHeight * 0.04, // Responsive top margin
            left: windowWidth * 0.01, // Responsive left margin
            child: IconButton(
              icon: Image.asset('assets/backarrow.png'),
              iconSize: windowWidth * 0.15, // Responsive size for back button
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Container(
              width: windowWidth * 0.9, // 90% of screen width
              height: windowHeight * 0.85, // 85% of screen height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: windowWidth * 0.05, vertical: windowHeight * 0.05), // Responsive padding
              margin: EdgeInsets.only(top: windowHeight * 0.1), // Responsive top margin
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(windowWidth),
                  _buildHorizontalLine(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildTextContent(windowWidth), // Pass windowWidth
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

  Widget _buildHeader(double windowWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/Info.png',
          width: windowWidth * 0.13, // Responsive image width
          height: windowWidth * 0.12, // Responsive image height
        ),
        SizedBox(width: windowWidth * 0.03), // Responsive spacing
        Text(
          'About Us',
          style: TextStyle(
            fontSize: windowWidth * 0.06, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalLine() {
    return Container(
      height: 2,
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 20), // Responsive margins
    );
  }

  Widget _buildTextContent(double windowWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: windowWidth * 0.05), // Equal left and right padding
      child: Text(
        '1. Equilibrease is designed to analyze the efficacy of home maneuvers for treating vertigo and to facilitate the follow-up of vertigo patients.\n\n'
            '2. User-Friendly Interface\n\n'
            '3. Home Maneuver home maneuvers.\n\n'
            '4. Some key points about the Equilibrease App:\n\n'
            '5. Equilibrease is designed to analyze the efficacy of home maneuvers for treating vertigo and to facilitate the follow-up of vertigo patients.\n\n'
            '6. User-Friendly Interface\n\n'
            '7. Home Maneuver home maneuvers.\n\n'
            '8. Some key points about the Equilibrease App:\n\n'
            '9. Equilibrease is designed to analyze the efficacy of home maneuvers for treating vertigo and to facilitate the follow-up of vertigo patients.\n\n'
            '10. User-Friendly Interface',
        style: TextStyle(
          fontSize: windowWidth * 0.04, // Responsive font size
          color: Colors.black,
        ),
      ),
    );
  }
}
