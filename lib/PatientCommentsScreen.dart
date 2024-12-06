import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding
import 'config.dart'; // Adjust the path as necessary

class PatientCommentsScreen extends StatefulWidget {
  final String patientId; // Required parameter

  // Constructor accepting patientId
  PatientCommentsScreen({required this.patientId});

  @override
  _PatientCommentsScreenState createState() => _PatientCommentsScreenState();
}

class _PatientCommentsScreenState extends State<PatientCommentsScreen> {
  List feedbackData = []; // Initialize as empty list

  @override
  void initState() {
    super.initState();
    fetchFeedbackData(); // Fetch data when the widget is initialized
  }

  // Fetch feedback data from the backend
  Future<void> fetchFeedbackData() async {
    try {
      final response = await http.get(Uri.parse(Config.getPatientComments));
      final feedbackResponse = json.decode(response.body);

      if (feedbackResponse['success'] == true &&
          feedbackResponse['comments'] is List) {
        setState(() {
          feedbackData = feedbackResponse['comments']; // Set the comments array
        });
      } else {
        print('Unexpected response format: $feedbackResponse');
      }
    } catch (error) {
      print('Error fetching feedback data: $error');
    }
  }

  // Navigate to AllPatientComments with feedbackId and patientId
  void handleViewFeedback(String feedbackId) {
    Navigator.pushNamed(context, '/AllPatientComment', arguments: {
      'feedbackId': feedbackId,
      'patientId': widget.patientId, // Use widget.patientId
    });
  }

  // Handle back navigation
  void handleBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE), // Total background color
      appBar: AppBar(
        title: Text('Pending Feedback'),
        backgroundColor: Colors.white, // White background for title box
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/backarrow.png', width: 24, height: 24),
          onPressed: handleBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: feedbackData.isEmpty
            ? Center(child: Text('No feedback data available.'))
            : ListView.builder(
          itemCount: feedbackData.length,
          itemBuilder: (context, index) {
            final feedback = feedbackData[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient ID: ${feedback['patientId']}', style: styles.feedbackText),
                  SizedBox(height: 8), // Add space between texts
                  Text('Video ID: ${feedback['video_id']}', style: styles.feedbackText),
                  SizedBox(height: 8),
                  Text('Feedback: ${feedback['selected_feedback']}', style: styles.feedbackText),
                  SizedBox(height: 8),
                  Text('Difficulty: ${feedback['difficulty_text']}', style: styles.feedbackText),
                  SizedBox(height: 8),
                  Text(
                    'Timestamp: ${DateTime.parse(feedback['timestamp']).toLocal()}',
                    style: styles.feedbackText,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => handleViewFeedback(feedback['feedback_id']),
                    child: Text('View'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Styles for the Flutter application
class styles {
  static const TextStyle feedbackText = TextStyle(
    fontSize: 16,
  );
}
