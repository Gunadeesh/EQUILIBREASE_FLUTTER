import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart'; // Import the config file for API URLs

class DoctorDashboard extends StatefulWidget {
  final String doctorID;
  const DoctorDashboard({Key? key, required this.doctorID}) : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<dynamic> newUsers = [];
  List<dynamic> topComments = [];
  bool loading = true;
  int notificationCount = 0;
  String doctorName = '';

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails();
    fetchNewUsers();
    fetchTopComments();
    fetchNotificationCount();
  }

  Future<void> fetchDoctorDetails() async {
    final url = Config.doctorDashboard(widget.doctorID);
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          doctorName = data['doctor']['name'];
        });
      }
    } catch (error) {
      print('Error fetching doctor details: $error');
    }
  }

  Future<void> fetchNewUsers() async {
    final url = Config.fetchNewUsers;
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          newUsers = data['newUsers'].take(2).toList();
          loading = false;
        });
      }
    } catch (error) {
      print('Error fetching new users: $error');
    }
  }

  Future<void> fetchTopComments() async {
    final url = Config.getPatientQueries;
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          topComments = data['patients'].toSet().toList().take(3).toList();
        });
      }
    } catch (error) {
      print('Error fetching top comments: $error');
    }
  }

  Future<void> fetchNotificationCount() async {
    final url = Config.getFeedbackCount;
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          notificationCount = data['count'];
        });
      }
    } catch (error) {
      print('Error fetching notification count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/Bulleted List.png'),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/doctorprofile.png'),
              radius: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Welcome, Dr. $doctorName',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis, // Prevent overflow by truncating
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Image.asset('assets/Add Reminder.png'),
                onPressed: () {
                  Navigator.pushNamed(context, '/patientCommentsScreen');
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset(
              'assets/dashboardimage.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            _buildSection(
              title: 'Patient Comments:',
              children: topComments.map((comment) {
                return _buildCommentCard(comment);
              }).toList(),
            ),
            SizedBox(height: 20),
            _buildSection(
              title: "Patient's Details:",
              children: newUsers.map((user) {
                return _buildUserCard(user);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF458ADB).withOpacity(0.67),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCommentCard(Map<String, dynamic> comment) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/questionReplyScreen', arguments: comment);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(comment['image_path']),
          ),
          title: Text('Patient ID: ${comment['patientId']}'),
          subtitle: Text('Query: ${comment['query']}'),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/questionReplyScreen', arguments: comment);
            },
            child: Text('View'),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/patientDetails', arguments: user['patientId']);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user['image_path']),
          ),
          title: Text('Patient ID: ${user['patientId']}'),
          subtitle: Text('Name: ${user['name']}'),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/patientDetails', arguments: user['patientId']);
            },
            child: Text('View'),
          ),
        ),
      ),
    );
  }
}
