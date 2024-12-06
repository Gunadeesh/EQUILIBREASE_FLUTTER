import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class CustomDrawerContent extends StatefulWidget {
  final String doctorID;
  final Function(String) onNavigate;

  const CustomDrawerContent({
    Key? key,
    required this.doctorID,
    required this.onNavigate,
  }) : super(key: key);

  @override
  _CustomDrawerContentState createState() => _CustomDrawerContentState();
}

class _CustomDrawerContentState extends State<CustomDrawerContent> {
  String doctorName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails();
  }

  Future<void> fetchDoctorDetails() async {
    final url = Config.doctorDashboard(widget.doctorID);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          setState(() {
            doctorName = data['doctor']['name'];
            isLoading = false;
          });
        } else {
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
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    const Color blueColor = Color(0xFFC5EDFE); // Define your blue color

    return Drawer(
      child: Container(
        color: blueColor, // Set the background color of the drawer
        child: Column(
          children: [
            // Profile section
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/doctorprofile.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, Dr. $doctorName',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), // Title color
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
                  _buildDrawerItem('Profile', '/profile', blueColor),
                  _buildDrawerItem('Add Patient', '/addPatient', blueColor),
                  _buildDrawerItem('Graph', '/graph', blueColor),
                  _buildDrawerItem('About Us', '/about', blueColor),
                  _buildDrawerItem('Help', '/help', blueColor),
                  _buildDrawerItem('Log Out', '/logout', blueColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, String route, Color color) {
    return Container(
      color: color, // Set the background color
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black), // Change text color to black
        ),
        onTap: () {
          widget.onNavigate(route); // Navigate to the specified route
        },
      ),
    );
  }
}
