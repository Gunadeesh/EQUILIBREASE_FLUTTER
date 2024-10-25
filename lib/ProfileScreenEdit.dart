import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart'; // Import GetX for navigation
import 'config.dart'; // Adjust the path as necessary
import 'PatientDashboard1.dart'; // Adjust the import based on your project structure

class ProfileScreenEdit extends StatefulWidget {
  final String patientId;

  const ProfileScreenEdit({Key? key, required this.patientId}) : super(key: key);

  @override
  _ProfileScreenEditState createState() => _ProfileScreenEditState();
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  late Dio dio;
  Map<String, dynamic>? patient;
  String name = '';
  String age = '';
  bool isEditing = false;
  String errorMessage = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dio = Dio();
    _loadPatientDetails();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _loadPatientDetails() async {
    if (widget.patientId.isEmpty || widget.patientId == 'invalid') {
      setState(() {
        errorMessage = 'Invalid patient ID provided.';
      });
      return;
    }

    try {
      final response = await dio.get(
        Config.getPatientDetails(widget.patientId),
      );

      if (response.data['success'] == true) {
        final fetchedPatient = response.data['patient'];
        setState(() {
          patient = fetchedPatient;
          name = fetchedPatient['name'];
          age = fetchedPatient['age'].toString();
          nameController.text = name;
          ageController.text = age;
          errorMessage = ''; // Clear error message
        });
      } else {
        _showAlert('Error', response.data['message'] ?? 'Invalid patient ID');
      }
    } catch (e) {
      _showAlert('Error', 'Failed to fetch patient details');
      print('Error fetching patient details: $e');
      print("Patient ID: ${widget.patientId}");
    }
  }

  Future<void> _handleUpdate() async {
    try {
      final response = await dio.post(
        Config.updatePatientDetails,
        data: {
          'patientId': widget.patientId,
          'name': nameController.text,
          'age': ageController.text,
        },
      );

      if (response.data['success'] == true) {
        _showAlert('Success', 'Details updated successfully');
        setState(() => isEditing = false);
      } else {
        _showAlert('Error', response.data['message'] ?? 'Update failed');
      }
    } catch (e) {
      _showAlert('Error', 'Failed to update details');
      print('Error updating details: $e');
    }
  }

  void _showAlert(String title, String message, [VoidCallback? onOk]) {
    Get.defaultDialog(
      title: title,
      content: Text(message),
      confirm: TextButton(
        onPressed: () {
          Get.back(); // Close the dialog
          if (onOk != null) onOk();
        },
        child: const Text('OK'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;

    if (patient == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back to PatientDashboard and pass the patientId
            Get.to(() => PatientDashboard1(patientId: widget.patientId));
          },
        ),
        title: const Text(
          'Edit Patient Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            if (patient != null) ...[
              CircleAvatar(
                radius: windowSize.width * 0.175,
                backgroundImage: NetworkImage(patient!['image_path']),
              ),
              const SizedBox(height: 20),
              _buildDetailText('Name: ${patient!['name']}'),
              _buildDetailText('Age: ${patient!['age']}'),
              _buildDetailText('Sex: ${patient!['sex']}'),
              _buildDetailText('ID: ${patient!['patientId']}'),
              const SizedBox(height: 20),
              isEditing ? _buildEditForm() : _buildEditButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        _buildTextInput('Name', nameController),
        const SizedBox(height: 10),
        _buildTextInput('Age', ageController, TextInputType.number),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _handleUpdate, child: const Text('Save')),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => setState(() => isEditing = false),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      controller: controller,
      keyboardType: keyboardType,
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () => setState(() => isEditing = true),
      child: const Text('Edit'),
    );
  }
}
