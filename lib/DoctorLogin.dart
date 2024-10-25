import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX package for navigation
import 'config.dart'; // Import the config file
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For JSON encoding/decoding

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  String doctorID = '';
  String password = '';

  void handleLogin() async {
    if (doctorID.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('${Config.docLog}?doctor_ID=$doctorID&password=$password'),
        );

        final data = json.decode(response.body);

        if (data['success']) {
          Get.toNamed('/DoctorDrawer', arguments: {'doctorId': doctorID});
        } else {
          Get.snackbar('Error', 'Invalid Doctor ID or Password. Please try again.', backgroundColor: Colors.red);
        }
      } catch (error) {
        print('Error during doctor login: $error');
        Get.snackbar('Error', 'An error occurred. Please try again later.', backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar('Input Error', 'Please enter both Doctor ID and Password.', backgroundColor: Colors.yellow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 10, top: 20),
                  child: Image.asset(
                    'assets/backarrow.png',
                    width: 67,
                    height: 36,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black),
                  color: Color(0xFFC5EDFE),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "DOCTOR'S LOGIN",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/doctor.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Doctor ID *',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        doctorID = value;
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Password *',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: handleLogin,
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                        minimumSize: Size(double.infinity, 35), // Full width
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.toNamed('/AdminScreen'), // Navigation to Admin Screen
                child: Text('Admin'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Match the login button style
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 35), // Same width as the container
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
