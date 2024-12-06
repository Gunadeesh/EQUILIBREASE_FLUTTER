import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class QuestionReplyScreen extends StatefulWidget {
  final Map<String, dynamic> patient;

  QuestionReplyScreen({required this.patient});

  @override
  _QuestionReplyScreenState createState() => _QuestionReplyScreenState();
}

class _QuestionReplyScreenState extends State<QuestionReplyScreen> {
  List<dynamic> feedbackDetails = [];
  Map<int, TextEditingController> replyControllers = {};
  int currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    fetchFeedbackDetails();
  }

  Future<void> fetchFeedbackDetails() async {
    try {
      final response = await http.get(Uri.parse(Config.getFeedbackDetails(widget.patient['patientId'])));
      final data = json.decode(response.body);

      setState(() {
        feedbackDetails = data is List ? data : [];
        for (var feedback in feedbackDetails) {
          replyControllers[feedback['feedback_id']] = TextEditingController();
        }
      });
    } catch (e) {
      print("Error fetching feedback details: $e");
    }
  }

  Future<void> handleSendReply(int feedbackId) async {
    final feedback = feedbackDetails.firstWhere((f) => f['feedback_id'] == feedbackId, orElse: () => null);
    if (feedback == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feedback not found")));
      return;
    }

    if (feedback['status'] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reply already sent")));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(Config.sendDoctorReply),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'patientId': widget.patient['patientId'],
          'feedbackId': feedbackId,
          'image': widget.patient['image_path'],
          'patientName': widget.patient['name'],
          'gender': widget.patient['sex'],
          'videoId': feedback['video_id'],
          'videoTitle': feedback['title'],
          'selectedFeedback': feedback['selected_feedback'],
          'difficulty': feedback['difficulty_text'],
          'patientComment': widget.patient['query'],
          'doctorReply': replyControllers[feedbackId]?.text ?? '',
          'status': 0,
        }),
      );

      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reply sent successfully")));
        setState(() {
          replyControllers[feedbackId]?.clear(); // Clear the reply text after sending
        });
        fetchFeedbackDetails(); // Refresh feedback details
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
      }
    } catch (e) {
      print("Error sending doctor reply: $e");
    }
  }

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    for (var controller in replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/backarrow.png'),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Patient's Comments", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: feedbackDetails.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final feedback = feedbackDetails[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          patientInfoCard(widget.patient, feedback),
                          commentCard("Selected Feedback", feedback['selected_feedback']),
                          commentCard("Difficulty", feedback['difficulty_text']),
                          commentCard("Patient Comment", widget.patient['query']),
                          SizedBox(height: 10),
                          TextField(
                            controller: replyControllers[feedback['feedback_id']],
                            decoration: InputDecoration(
                              hintText: feedback['status'] == 1 ? 'Reply already sent' : 'Type your reply here',
                              filled: true,
                              fillColor: feedback['status'] == 1 ? Color(0xFFF0F0F0) : Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            enabled: feedback['status'] != 1,
                            maxLines: 4,
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (feedback['status'] == 1) return Colors.grey[300]!;
                                  return Colors.blue;
                                },
                              ),
                            ),
                            onPressed: feedback['status'] == 1 ? null : () => handleSendReply(feedback['feedback_id']),
                            child: Text(
                              feedback['status'] == 1 ? 'Reply Sent' : 'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("${currentIndex + 1} / ${feedbackDetails.length}", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget patientInfoCard(patient, feedback) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(patient['image_path']),
          radius: 25,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient ID: ${patient['patientId']}"),
              Text("Name: ${patient['name']}"),
              Text("Gender: ${patient['sex']}"),
              Text("Video ID: ${feedback['video_id']}"),
              Text("Video Title: ${feedback['title']}"),
            ],
          ),
        ),
      ],
    );
  }

  Widget commentCard(String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(content),
        ],
      ),
    );
  }
}
