import 'package:flutter/material.dart';

class AboutScreenPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;
    final double windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: Stack(
        children: [
          // Back button
          Positioned(
            top: windowHeight * 0.03,
            left: windowWidth * 0.01,
            child: IconButton(
              icon: Image.asset('assets/backarrow.png', width: windowWidth * 0.15, height: windowWidth * 0.15),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Inner container
          Padding(
            padding: EdgeInsets.all(windowWidth * 0.01),
            child: Center(
              child: Container(
                width: windowWidth * 0.9,
                height: windowHeight * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(windowWidth * 0.05),
                margin: EdgeInsets.only(top: windowHeight * 0.1), // Updated margin
                child: Column(
                  children: [
                    // Heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Info.png', width: windowWidth * 0.13, height: windowWidth * 0.12),
                        SizedBox(width: windowWidth * 0.03),
                        Text(
                          'About us',
                          style: TextStyle(
                            fontSize: windowWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Horizontal line
                    Divider(color: Colors.black, thickness: 2),
                    // Text container
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: windowHeight * 0.02),
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
                              fontSize: windowWidth * 0.04,
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
