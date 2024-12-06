import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class PatientDetails extends StatefulWidget {
  final String patientId;

  PatientDetails({required this.patientId});

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  Map<String, dynamic>? patient;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPatientDetails();
  }

  Future<void> fetchPatientDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.detailsofpatient}?patientId=${widget.patientId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            patient = data['patient'];
            loading = false;
          });
        } else {
          setState(() {
            error = data['message'];
            loading = false;
          });
        }
      } else {
        setState(() {
          error = 'Failed to load patient details';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'An error occurred while fetching patient details.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF458ADB)),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            error!,
            style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: IconButton(
                    icon: Image.asset('assets/backarrow.png', width: screenWidth * 0.15, height: screenHeight * 0.05),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Patient's Details",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            CircleAvatar(
              radius: screenWidth * 0.15,
              backgroundImage: NetworkImage(patient!['image_path']),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Name', patient!['name'], screenWidth),
                  _buildDetailRow('Patient ID', patient!['patientId'], screenWidth),
                  _buildDetailRow('Age', patient!['age'].toString(), screenWidth),
                  _buildDetailRow('Sex', patient!['sex'], screenWidth),
                  _buildDetailRow('Occupation', patient!['occupation'], screenWidth),
                  _buildDetailRow('Diagnosis', patient!['diagnosis'], screenWidth),
                  _buildDetailRow('Comorbidities', patient!['comorbidities'], screenWidth),
                  _buildDetailRow('Investigations Done', patient!['investigations'], screenWidth),
                  _buildDetailRow('Examination', patient!['examination'], screenWidth),
                  _buildDetailRow('Medications Prescribed', patient!['medications'], screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
