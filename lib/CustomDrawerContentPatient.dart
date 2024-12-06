import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart'; // Ensure to have your config file imported

class CustomDrawerContentPatient extends StatefulWidget {
  final String patientId;
  final Function(String) onNavigate; // Function for navigation
  final Function onLogout; // Add onLogout parameter

  const CustomDrawerContentPatient({
    Key? key,
    required this.patientId,
    required this.onNavigate, // Initialize the onNavigate parameter
    required this.onLogout, // Initialize the onLogout parameter
  }) : super(key: key);

  @override
  _CustomDrawerContentPatientState createState() => _CustomDrawerContentPatientState();
}

class _CustomDrawerContentPatientState extends State<CustomDrawerContentPatient> {
  String patientName = '';
  String? patientImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('Patient ID in CustomDrawerContentPatient: ${widget.patientId}');
    fetchPatientDetails();
  }

  Future<void> fetchPatientDetails() async {
    if (widget.patientId.isNotEmpty && widget.patientId != 'guest') {
      try {
        print('Fetching details for patient ID: ${widget.patientId}');
        final response = await http.get(Uri.parse(Config.patientDashboard(widget.patientId)));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            patientName = data['patientName'];
            patientImage = '${data['patientImage']}?timestamp=${DateTime.now().millisecondsSinceEpoch}';
            isLoading = false;
          });
          print('Patient details fetched successfully.');
        } else {
          setState(() {
            patientName = 'Error loading patient profile';
            isLoading = false;
          });
          print('Failed to load patient profile for ID: ${widget.patientId}');
        }
      } catch (error) {
        print('Error fetching patient profile: $error');
        setState(() {
          patientName = 'Error fetching patient profile';
          isLoading = false;
        });
      }
    } else {
      setState(() {
        patientName = 'Guest';
        isLoading = false;
      });
      print('Patient ID is empty or guest.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Drawer(
      child: Container(
        color: const Color(0xFFC5EDFE), // Set the background color of the drawer
        child: Column(
          children: [
            // Profile section
            _buildHeader(),
            // Drawer items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem('Profile Edit', '/profile'),
                  _buildDrawerItem('My Details', '/myDetails'),
                  _buildDrawerItem('Doctor Replies', '/doctorReplies'),
                  _buildDrawerItem('About Us', '/about'),
                  _buildDrawerItem('Help', '/help'),
                  // Change the 'Log Out' ListTile to use the onLogout function
                  ListTile(
                    title: Text('Log Out'),
                    onTap: () {
                      widget.onLogout(); // Call the onLogout function
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFFC5EDFE),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.1,
            backgroundImage: patientImage != null
                ? NetworkImage(patientImage!)
                : const AssetImage('assets/Patientimg.png') as ImageProvider,
          ),
          const SizedBox(height: 10),
          Text(
            patientName,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, String route) {
    return ListTile(
      title: Text(title),
      onTap: () {
        widget.onNavigate(route); // Navigate to the specified route
      },
    );
  }
}
