import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class ProfileScreen extends StatefulWidget {
  final String doctorID;
  const ProfileScreen({Key? key, required this.doctorID}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> doctorDetails = {};
  bool isLoading = true;
  bool isEditable = false;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    fetchDoctorDetails();
  }

  Future<void> fetchDoctorDetails() async {
    try {
      final response = await http.get(Uri.parse(Config.getDoctorDetails(widget.doctorID)));
      if (response.statusCode == 200) {
        setState(() {
          doctorDetails = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print('Failed to load doctor details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveDoctorDetails() async {
    try {
      final response = await http.post(
        Uri.parse(Config.updateDoctorDetails), // Ensure URL is correct
        headers: {'Content-Type': 'application/json'},
        body: json.encode(doctorDetails),
      );

      // Log response for debugging
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the success message exists
        if (data['success'] == 'Doctor details updated successfully') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Doctor details updated successfully')),
          );
          setState(() => isEditable = false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['error'] ?? 'Failed to update doctor details'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the icon vertically
          children: [
            SizedBox(height: 8), // Adjust the height as needed
            IconButton(
              icon: Image.asset('assets/backarrow.png', width: 64, height: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView( // Added scrollable functionality
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Doctor Profile',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/doctorprofile.png', width: 120, height: 120),
              const SizedBox(height: 20),
              buildDetailBox('Name', 'name'),
              buildDetailBox('Doctor ID', 'doctor_ID'),
              buildPasswordBox(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => setState(() => isEditable = !isEditable),
                child: Text(isEditable ? 'Cancel' : 'Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
              if (isEditable)
                ElevatedButton(
                  onPressed: saveDoctorDetails,
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailBox(String label, String key) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: doctorDetails[key],
            enabled: isEditable,
            onChanged: (value) => setState(() => doctorDetails[key] = value),
            style: const TextStyle(fontSize: 18, color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordBox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: doctorDetails['password'],
              enabled: isEditable,
              obscureText: !isPasswordVisible,
              onChanged: (value) => setState(() => doctorDetails['password'] = value),
              style: const TextStyle(fontSize: 18, color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
            ),
          ),
          IconButton(
            icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
          ),
        ],
      ),
    );
  }
}
