import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart'; // Ensure to have your config file imported

class CustomDrawerContentPatient extends StatefulWidget {
  final String patientId;
  final VoidCallback? onLogout; // Add this line

  const CustomDrawerContentPatient({Key? key, required this.patientId, this.onLogout}) : super(key: key);

  @override
  _CustomDrawerContentPatientState createState() => _CustomDrawerContentPatientState();
}

class _CustomDrawerContentPatientState extends State<CustomDrawerContentPatient> {
  String patientName = '';
  String? patientImage;
  bool isLoading = true;
  String? errorMessage;

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
            errorMessage = 'Failed to load patient profile';
            isLoading = false;
          });
          print('Failed to load patient profile for ID: ${widget.patientId}');
        }
      } catch (error) {
        print('Error fetching patient profile: $error');
        setState(() {
          errorMessage = 'Error fetching patient profile';
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

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView(
            children: [
              _buildDrawerItem(title: 'Profile Edit', route: 'Profile'),
              _buildDrawerItem(title: 'My Details', route: 'MyDetailsScreen'),
              _buildDrawerItem(title: 'Doctor Replies', route: 'DoctorRepliesScreen'),
              _buildDrawerItem(title: 'About Us', route: 'AboutScreenPatient'),
              _buildDrawerItem(title: 'Help', route: 'HelpScreenPatient'),
              _buildDrawerItem(
                title: 'Log Out',
                onTap: () {
                  if (widget.onLogout != null) {
                    widget.onLogout!(); // Call the logout function
                  }
                },
              ),
            ],
          ),
        ),
      ],
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
            backgroundImage: NetworkImage(
              patientImage ?? 'assets/Patientimg.png',
            ),
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

  Widget _buildDrawerItem({required String title, String? route, VoidCallback? onTap}) {
    return ListTile(
      title: Text(title),
      onTap: () async {
        Navigator.of(context).pop(); // Close the drawer before navigating
        await Future.delayed(const Duration(milliseconds: 200)); // Add delay to prevent glitches

        if (onTap != null) {
          onTap();
        } else if (route != null) {
          _navigateTo(route);
        }
      },
    );
  }

  void _navigateTo(String route) {
    print('Navigating to: $route with Patient ID: ${widget.patientId}');
    Navigator.of(context).pushReplacementNamed(route, arguments: widget.patientId);
  }
}
