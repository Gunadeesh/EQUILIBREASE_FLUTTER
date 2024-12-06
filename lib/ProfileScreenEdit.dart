import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'config.dart';
import 'PatientDashboard1.dart';

class ProfileScreenEdit extends StatefulWidget {
  final String patientId;

  const ProfileScreenEdit({Key? key, required this.patientId}) : super(key: key);

  @override
  _ProfileScreenEditState createState() => _ProfileScreenEditState();
}

class _ProfileScreenEditState extends State<ProfileScreenEdit> {
  late Dio dio;
  Map<String, dynamic>? patient;
  bool isEditing = false;
  String errorMessage = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dio = Dio();
    _checkGuestAccess();
    _loadPatientDetails();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void _checkGuestAccess() {
    if (widget.patientId == 'guest') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Guest Access'),
                content: const Text('Please contact your doctor for account creation.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  Future<void> _loadPatientDetails() async {
    if (widget.patientId == 'guest') return;

    try {
      final response = await dio.get(Config.getPatientDetails(widget.patientId));
      if (response.data['success'] == true) {
        final fetchedPatient = response.data['patient'];
        setState(() {
          patient = fetchedPatient;
          nameController.text = fetchedPatient['name'];
          ageController.text = fetchedPatient['age'].toString();
        });
      } else {
        _showAlert('Error', response.data['message'] ?? 'Invalid patient ID');
      }
    } catch (e) {
      _showAlert('Error', 'Failed to fetch patient details');
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
    }
  }

  void _showAlert(String title, String message, [VoidCallback? onOk]) {
    Get.defaultDialog(
      title: title,
      content: Text(message),
      confirm: TextButton(
        onPressed: () {
          Get.back();
          if (onOk != null) onOk();
        },
        child: const Text('OK'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFC5EDFE),
      body: SingleChildScrollView( // Added scrollable container here
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 0.5),
                child: Image.asset(
                  'assets/backarrow.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Patient's Details Title in Container
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Patient's Details",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Main Content Container for Patient Info
            patient == null
                ? const Center(child: CircularProgressIndicator())
                : Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
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
              ),
            ),
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
