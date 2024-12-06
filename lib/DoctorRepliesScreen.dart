import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'config.dart'; // Import your config file
import 'package:get/get.dart';
import 'PatientDashboard1.dart';

class DoctorRepliesScreen extends StatefulWidget {
  final String patientId;

  const DoctorRepliesScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  _DoctorRepliesScreenState createState() => _DoctorRepliesScreenState();
}

class _DoctorRepliesScreenState extends State<DoctorRepliesScreen> {
  List<dynamic> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.patientId == "guest") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showGuestAlert();
      });
      setState(() {
        isLoading = false; // Stop loading if guest
      });
      return; // Stop further execution
    }
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final response = await Dio().get(Config.getNotificationDetails(widget.patientId));
      setState(() {
        notifications = response.data['notifications'] ?? [];
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching notifications: $error');
      _showErrorAlert('Failed to fetch notifications.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> handleViewNotification(dynamic notification) async {
    try {
      final response = await Dio().post(
        Config.updateReplyStatus,
        data: {
          'patientId': widget.patientId,
          'video_id': notification['video_id'],
          'reply_timestamp': notification['reply_timestamp']
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.data['success']) {
        _showSuccessAlert('Reply status updated to viewed.');
        setState(() {
          notifications = notifications.map((n) {
            return n['id'] == notification['id'] ? {...n, 'reply_sent': 2} : n;
          }).toList();
        });
      } else {
        _showErrorAlert('Failed to update the reply status.');
      }
    } catch (error) {
      print('Error updating reply status: $error');
      _showErrorAlert('Could not update the reply status.');
    }
  }

  void _showGuestAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Guest Access'),
          content: const Text('Please contact your doctor for account creation.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close current screen to return to previous
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('PatientDashboard1'); // Navigate to PatientDashboard1
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 20), // Move the replies down
              if (notifications.isEmpty)
                Center(child: Text('No replies from the doctor yet.'))
              else
                ..._buildNotificationCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Image.asset('assets/backarrow.png', width: 55, height: 55),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(width: 20), // Add space between back arrow and title
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'Doctor Replies',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildNotificationCards() {
    return notifications.map((notification) {
      return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient: ${notification['name']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Gender: ${notification['gender']}', style: TextStyle(fontSize: 16)),
            Text('Video Title: ${notification['video_title']}', style: TextStyle(fontSize: 16)),
            Text('Feedback: ${notification['selected_feedback']}', style: TextStyle(fontSize: 14)),
            Text('Difficulty: ${notification['difficulty_text']}', style: TextStyle(fontSize: 14)),
            Text('Patient Comment: ${notification['patient_comment']}', style: TextStyle(fontSize: 14)),
            Text('Doctor Reply: ${notification['doctor_reply']}', style: TextStyle(fontSize: 14)),
            Text('Reply Sent Time: ${notification['reply_timestamp']}', style: TextStyle(fontSize: 14)),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF007bff), // Button color
              ),
              onPressed: () => handleViewNotification(notification),
              child: Text('View', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }).toList();
  }
}
