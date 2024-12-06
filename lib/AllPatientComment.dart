import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class PatientQueriesScreen extends StatefulWidget {
  @override
  _PatientQueriesScreenState createState() => _PatientQueriesScreenState();
}

class _PatientQueriesScreenState extends State<PatientQueriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> patients = [];
  List<dynamic> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      final response = await http.get(Uri.parse(Config.getPatientQueries));
      final data = json.decode(response.body);

      setState(() {
        patients = data['patients'] ?? [];
        filteredPatients = patients;
      });
    } catch (e) {
      print("Error fetching patients: $e");
    }
  }

  void handleSearch(String text) {
    setState(() {
      filteredPatients = patients.where((patient) {
        final name = patient['name'].toLowerCase();
        final id = patient['patientId'].toString().toLowerCase();
        return name.contains(text.toLowerCase()) || id.contains(text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/backarrow.png'),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Patient Queries", style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: handleSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, size: screenWidth * 0.06),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  final patient = filteredPatients[index];
                  final videos = (patient['videos'] as String?)?.split(',') ?? [];

                  return Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(patient['image_path']),
                          radius: screenWidth * 0.06,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Patient ID: ${patient['patientId']}"),
                              Text("Name: ${patient['name']}"),
                              Text("Age: ${patient['age']}"),
                              Text("Sex: ${patient['sex']}"),
                              Text("Videos: ${videos.join(', ')}"),
                              Text("Query: ${patient['query']}"),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/QuestionReplyScreen',
                                arguments: {
                                  'patientId': patient['patientId'],
                                  'patient': patient,
                                });
                          },
                          child: Text("View"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC5EDFE),
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
