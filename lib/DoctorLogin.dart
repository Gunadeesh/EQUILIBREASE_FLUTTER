import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'config.dart'; // Importing config.dart

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  final TextEditingController _doctorIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio dio = Dio();

  void _handleLogin() async {
    String doctorId = _doctorIdController.text.trim();
    String password = _passwordController.text.trim();

    if (doctorId.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await dio.get(Config.docLog, queryParameters: {
          'doctor_ID': doctorId,
          'password': password,
        });

        if (response.data['success']) {
          print('Login successful, navigating to DoctorDrawer');
          Get.toNamed('/DoctorDrawer', arguments: {'doctorId': doctorId});
        } else {
          _showAlert('Invalid credentials. Please try again.');
        }
      } catch (e) {
        print('Error during doctor login: $e');
        _showAlert('An error occurred. Please try again later.');
      }
    } else {
      _showAlert('Please enter both Doctor ID and Password.');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Image.asset('assets/backarrow.png'),
                iconSize: 40,
                onPressed: () {
                  Navigator.pushNamed(context, '/DoctorPatient');
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: windowWidth * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC5EDFE),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "DOCTOR'S LOGIN",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/doctor.png',
                        width: windowWidth * 0.5,
                        height: windowWidth * 0.5,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _doctorIdController,
                        decoration: const InputDecoration(
                          hintText: 'Doctor ID *',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password *',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        onPressed: _handleLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Same color as Login button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        onPressed: () {
                          Get.toNamed('/AdminScreen'); // Navigate to AdminScreen
                        },
                        child: const Text(
                          'Admin Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
