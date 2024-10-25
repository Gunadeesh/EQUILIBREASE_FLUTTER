import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'config.dart'; // Import the config file

class CustomDrawerContent extends StatefulWidget {
  final String doctorID; // Receive doctor_ID from parent

  const CustomDrawerContent({Key? key, required this.doctorID}) : super(key: key);

  @override
  _CustomDrawerContentState createState() => _CustomDrawerContentState();
}

class _CustomDrawerContentState extends State<CustomDrawerContent> {
  String doctorName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails(); // Fetch doctor details on initialization
  }

  // Fetch doctor details from the API using dynamic config URL
  Future<void> fetchDoctorDetails() async {
    final url = Config.doctorDashboard(widget.doctorID); // Generate the API URL

    try {
      final response = await http.get(Uri.parse(url)); // Send GET request

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          // Successfully fetched doctor name
          setState(() {
            doctorName = data['doctor']['name'];
            isLoading = false;
          });
        } else {
          // Handle API response with failure
          print('Error: ${data['message']}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Error: Failed to load doctor details.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching doctor details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while data is being fetched
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Display drawer content after data is loaded
    return Drawer(
      child: Column(
        children: [
          // Profile section
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  'assets/doctorprofile.png', // Ensure this image exists in your assets
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome, Dr. $doctorName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Drawer items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    // Navigate to the dashboard page
                  },
                ),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    // Navigate to the profile page
                  },
                ),
                // Add more items as needed...
              ],
            ),
          ),
        ],
      ),
    );
  }
}
