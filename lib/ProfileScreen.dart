import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class ProfileScreen extends StatefulWidget {
  final String doctorId;
  const ProfileScreen({Key? key, required this.doctorId}) : super(key: key);

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
      final response = await http.get(Uri.parse(Config.getDoctorDetails(widget.doctorId)));
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
        Uri.parse(Config.updateDoctorDetails),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(doctorDetails),
      );
      final data = json.decode(response.body);

      if (data['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Doctor details updated successfully')),
        );
        setState(() => isEditable = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update details')),
        );
      }
    } catch (e) {
      print('Error: $e');
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                ),
              ),
              if (isEditable)
                ElevatedButton(
                  onPressed: saveDoctorDetails,
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
