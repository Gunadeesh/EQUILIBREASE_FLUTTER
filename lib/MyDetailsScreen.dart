import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'config.dart';
import 'PatientDashboard1.dart';

class MyDetailsScreen extends StatefulWidget {
  final String patientId;

  MyDetailsScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  _MyDetailsScreenState createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  late Future<Map<String, dynamic>> _patientDetails;
  bool _isGuest = false;

  @override
  void initState() {
    super.initState();
    if (widget.patientId != 'guest') {
      _patientDetails = _loadPatientDetails();
    } else {
      _isGuest = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isGuest) {
      _checkGuestAccess();
    }
  }

  Future<Map<String, dynamic>> _loadPatientDetails() async {
    final dio = Dio();
    try {
      final response = await dio.get(Config.getPatientDetails(widget.patientId));
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

  void _checkGuestAccess() {
    if (widget.patientId == 'guest') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) { // Ensure the widget is still in the widget tree
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Arrow Image with Padding
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 0.5),
                child: Image.asset(
                  'assets/backarrow.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Patient's Details Title Container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Patient's Details",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Patient's Details Data
            widget.patientId == 'guest'
                ? Center(child: Text('Guest access - contact doctor for account creation.'))
                : FutureBuilder<Map<String, dynamic>>(
              future: _patientDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Failed to load patient details',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  final patient = snapshot.data!;
                  return Column(
                    children: [
                      // Patient Image
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(patient['image_path'] ?? ''),
                      ),
                      const SizedBox(height: 20),

                      // Details Container
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
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
                              DetailRow(detail['label'], detail['value'] ?? 'N/A'),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
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
