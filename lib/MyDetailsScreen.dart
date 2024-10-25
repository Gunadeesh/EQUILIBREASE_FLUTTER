import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio
import 'config.dart'; // Import your config file

class MyDetailsScreen extends StatefulWidget {
  final String patientId;

  MyDetailsScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  _MyDetailsScreenState createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  late Future<Map<String, dynamic>> _patientDetails;

  @override
  void initState() {
    super.initState();
    if (widget.patientId == 'guest') {
      _showGuestAlert();
      return; // Stop further execution if guest
    }
    _patientDetails = _loadPatientDetails();
  }

  Future<Map<String, dynamic>> _loadPatientDetails() async {
    final dio = Dio(); // Create an instance of Dio
    try {
      // Make a GET request using the configured URL and pass the patientId as a query parameter
      final response = await dio.get(
        Config.getPatientDetails(widget.patientId), // Fetching URL from config with patientId
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          return data['patient'];
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch patient details');
        }
      } else {
        throw Exception('Failed to load patient details');
      }
    } catch (e) {
      throw Exception('Failed to load patient details: $e');
    }
  }

  void _showGuestAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notice'),
          content: Text('Please contact your doctor for account creation.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('PatientDashboard1'); // Navigate
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient's Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _patientDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load patient details', style: TextStyle(color: Colors.red)));
          } else {
            final patient = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(patient['image_path'] ?? ''), // Handle potential null
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        for (var detail in [
                          {"label": "Name:", "value": patient['name'] ?? 'N/A'},
                          {"label": "Patient's ID:", "value": patient['patientId'] ?? 'N/A'},
                          {"label": "Age:", "value": patient['age']?.toString() ?? 'N/A'},
                          {"label": "Sex:", "value": patient['sex'] ?? 'N/A'},
                          {"label": "Occupation:", "value": patient['occupation'] ?? 'N/A'},
                          {"label": "Diagnosis:", "value": patient['diagnosis'] ?? 'N/A'},
                          {"label": "Comorbidities:", "value": patient['comorbidities'] ?? 'N/A'},
                          {"label": "Investigations Done:", "value": patient['investigations'] ?? 'N/A'},
                          {"label": "Examination:", "value": patient['examination'] ?? 'N/A'},
                          {"label": "Medications Prescribed:", "value": patient['medications'] ?? 'N/A'},
                        ])
                          DetailRow(detail['label'], detail['value'] ?? 'N/A'), // Use 'N/A' for null values
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
