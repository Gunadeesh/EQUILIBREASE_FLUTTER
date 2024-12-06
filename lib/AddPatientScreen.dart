import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  Map<String, String> form = {
    'name': '',
    'age': '',
    'sex': '',
    'patientId': '',
    'password': '',
    'occupation': '',
    'diagnosis': '',
    'comorbidities': '',
    'investigations': '',
    'examination': '',
    'medications': ''
  };

  File? _image;

  void _handleInputChange(String field, String value) {
    setState(() {
      form[field] = value;
      if (field == 'name' || field == 'age') {
        if (form['name']!.isNotEmpty && form['age']!.isNotEmpty) {
          form['patientId'] = "${form['name']!.substring(0, 4)}${form['age']}";
          form['password'] = "${form['name']!.substring(0, 4)}@${form['age']}";
        }
      }
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly')),
      );
      return;
    }

    _formKey.currentState!.save();

    try {
      final request = http.MultipartRequest('POST', Uri.parse(Config.signup));

      // Add text fields to the request
      form.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add the image file, if present
      if (_image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',  // key expected by the server
            _image!.path,
          ),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      if (response.statusCode == 200 && responseData['success']) {
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add patient: ${responseData['message']}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Patient Added"),
        content: Text("Patient added successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);  // Close the dialog
              Navigator.pop(context);  // Remove the current AddPatientScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPatientScreen()),
              ); // Push a new AddPatientScreen instance
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/backarrow.png', // Replace with your image path
                      width: 40, // Set desired width
                      height: 44, // Set desired height
                    ),
                  ),
                  SizedBox(width: 10), // Space between back arrow and title
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF4A90E2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add Patient",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ..._buildInputFields(screenWidth),
              SizedBox(height: screenHeight * 0.02), // Space between fields and submit button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5CB85C),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                ),
                onPressed: _handleSubmit,
                child: Center(
                  child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Space after button
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputFields(double width) {
    return [
      buildTextField('Name', 'Enter name', 'name', width),
      buildTextField('Age', 'Enter age', 'age', width, inputType: TextInputType.number),
      buildTextField('Sex', 'Enter sex', 'sex', width),
      buildReadOnlyField('Patient ID', form['patientId'] ?? '', width),
      buildReadOnlyField('Password', form['password'] ?? '', width),
      buildImageUploadButton(width),
      if (_image != null)
        Container(
          alignment: Alignment.center,
          child: Image.file(_image!, width: width * 0.4, height: width * 0.4),
        ),
      buildTextField('Occupation', 'Enter occupation', 'occupation', width, maxLines: 3),
      buildTextField('Diagnosis', 'Enter diagnosis', 'diagnosis', width, maxLines: 3),
      buildTextField('Comorbidities', 'Enter comorbidities', 'comorbidities', width, maxLines: 3),
      buildTextField('Investigations', 'Enter investigations', 'investigations', width, maxLines: 3),
      buildTextField('Examination', 'Enter examination', 'examination', width, maxLines: 3),
      buildTextField('Medications', 'Enter medications', 'medications', width, maxLines: 3),
    ];
  }

  Widget buildTextField(String label, String hint, String field, double width,
      {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: width, // Set width to the provided width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.045)),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: hint,
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none, // Remove the border for a clean look
              ),
              onChanged: (value) => _handleInputChange(field, value),
              keyboardType: inputType,
              maxLines: maxLines,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReadOnlyField(String label, String value, double width) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: width, // Set width to the provided width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.045)),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(value, style: TextStyle(color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageUploadButton(double width) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 3),
          ],
        ),
        child: TextButton(
          onPressed: _pickImage,
          child: Text("Upload Image", style: TextStyle(color: Colors.blue)),
        ),
      ),
    );
  }
}
