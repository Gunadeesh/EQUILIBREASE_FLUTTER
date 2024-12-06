import 'package:flutter/material.dart';
import 'config.dart';
import 'PatientDetails.dart';
import 'AddPatientScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllPatientDetails extends StatefulWidget {
  @override
  _AllPatientDetailsState createState() => _AllPatientDetailsState();
}

class _AllPatientDetailsState extends State<AllPatientDetails> {
  List patients = [];
  bool loading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      final response = await http.post(Uri.parse(Config.fetchPatients));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            patients = data['patients'];
          });
        } else {
          print(data['message']);
        }
      } else {
        print("Failed to fetch patients.");
      }
    } catch (e) {
      print("Error fetching patients: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  List get filteredPatients {
    return patients.where((patient) {
      final name = patient['name'].toLowerCase();
      final patientId = patient['patientId'].toString().toLowerCase();
      return name.contains(searchQuery.toLowerCase()) ||
          patientId.contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return loading
        ? Center(child: CircularProgressIndicator(color: Colors.blue))
        : Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.10),
                child: IconButton(
                  icon: Image.asset('assets/backarrow.png'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
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
                child: Text(
                  "All Patient List's",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF458ADB),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (text) => setState(() => searchQuery = text),
              ),
              SizedBox(height: 20),
              Container(
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
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: filteredPatients.map((patient) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientDetails(
                              patientId: patient['patientId'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                NetworkImage(patient['image_path'] ?? ''),
                                radius: 30,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Patient ID: ${patient['patientId']}'),
                                  Text('Name: ${patient['name']}'),
                                  Text('Gender: ${patient['sex']}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Center(  // Center widget added here
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF458ADB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPatientScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Add Patient',
                    style: TextStyle(color: Colors.black), // Text color to black
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
