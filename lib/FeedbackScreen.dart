import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart'; // Adjust the path accordingly

class FeedbackScreen extends StatefulWidget {
  final String videoId;
  final String patientId;

  const FeedbackScreen({Key? key, required this.videoId, required this.patientId}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selectedFeedback = '';
  bool havingDifficulties = false;
  String difficultyText = '';
  String patientName = '';
  bool loading = true;

  List<Map<String, String>> feedbackOptions = [
    {'id': '1', 'text': '0 - 1 : No Improvement'},
    {'id': '2', 'text': '2 - 4 : Mild Improvement'},
    {'id': '3', 'text': '5 - 7 : Moderate Improvement'},
    {'id': '4', 'text': '8 - 10 : Feeling Relieved'},
  ];

  @override
  void initState() {
    super.initState();
    print('FeedbackScreen initialized with patientId: ${widget.patientId}');
    print('FeedbackScreen initialized with videoId: ${widget.videoId}');
    fetchPatientDetails();
  }

  Future<void> fetchPatientDetails() async {
    try {
      final response = await http.get(Uri.parse(Config.patientDashboard(widget.patientId)));
      final data = json.decode(response.body);
      setState(() {
        patientName = data['patientName'];
      });
    } catch (error) {
      print('Error fetching patient details: $error');
      showErrorDialog('Failed to fetch patient details.');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> handleSubmit() async {
    try {
      final response = await http.post(
        Uri.parse(Config.submitFeedback),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'patientId': widget.patientId,
          'videoId': int.parse(widget.videoId), // ensure videoId is sent as an int
          'selectedFeedback': selectedFeedback,
          'havingDifficulties': havingDifficulties,
          'difficultyText': difficultyText,
        }),
      );
      print('Response body: ${response.body}');

      final data = json.decode(response.body);
      if (data['success']) {
        // Show success dialog
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Feedback successfully submitted!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // Close the dialog
                  // Navigate to PatientDrawer and pass arguments if needed
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/PatientDrawer',
                        (route) => false,
                    arguments: {'patientId': widget.patientId, 'completedVideoId': widget.videoId},
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showErrorDialog(data['message']);
      }
    } catch (error) {
      print('Error submitting feedback: $error');
      showErrorDialog('Failed to submit feedback.');
    }
  }



  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowHeight = MediaQuery.of(context).size.height;

    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: SingleChildScrollView( // Wrap the body in SingleChildScrollView
        padding: EdgeInsets.symmetric(horizontal: windowWidth * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Button Positioned at the bottom
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: windowHeight * 0.02),
                    child: Image.asset(
                      'assets/backarrow.png',
                      width: windowWidth * 0.19,
                      height: windowWidth * 0.19,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1),
              Image.asset(
                'assets/thanks.png',
                width: double.infinity,
                height: windowHeight * 0.2,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFADD8E6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'FEEDBACK',
                        style: TextStyle(
                          fontSize: windowWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ...feedbackOptions.map((option) {
                      return Row(
                        children: [
                          Checkbox(
                            value: selectedFeedback == option['text'],
                            onChanged: (value) {
                              if (value!) {
                                setState(() {
                                  selectedFeedback = option['text']!;
                                });
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              option['text']!,
                              style: TextStyle(
                                fontSize: windowWidth * 0.045,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: havingDifficulties,
                    onChanged: (value) {
                      setState(() {
                        havingDifficulties = value!;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Having any Difficulties',
                      style: TextStyle(
                        fontSize: windowWidth * 0.045,
                      ),
                    ),
                  ),
                ],
              ),
              if (havingDifficulties)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Please describe your difficulties',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        difficultyText = value;
                      });
                    },
                  ),
                ),
              ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: windowWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // This is where you were missing a closing brace
} // Add this closing brace to end the _FeedbackScreenState class
