// config.dart

const String ip = "192.168.32.108"; // Define IP with port
const String baseUrl = "http://$ip/equilibrease"; // Adjusted base URL to include the app folder

class Config {
  // Authentication and User Management
  static const String login = "$baseUrl/Patientlogin.php"; // Patient login
  static const String signup = "$baseUrl/add_patient.php"; // Add patient
  static const String docLog = "$baseUrl/doctorlogin.php"; // Doctor login

  // Admin and Dashboard URLs
  static const String adminAddDoctor = "$baseUrl/addDoctor.php"; // Add Doctor (Admin)
  static const String fetchPatients = "$baseUrl/fetchPatients.php"; // Fetch all patients
  static const String getPatientQueries = "$baseUrl/get_patient_queries.php"; // Get patient queries
  static String doctorDashboard(String doctorId) =>
      "$baseUrl/DoctorDetails.php?doctorId=$doctorId"; // Doctor dashboard with dynamic doctorId
  static const String fetchNewUsers = "$baseUrl/fetchNewUsers.php"; // Fetch new users

  // Patient Dashboard and Feedback URLs
  static String patientDashboard(String patientId) =>
      "$baseUrl/PatientDashboard1.php?patientId=$patientId"; // Patient dashboard
  static const String submitFeedback = "$baseUrl/submit_feedback.php"; // Submit feedback
  static const String getFeedbackCount = "$baseUrl/fetchFeedbackCount.php"; // Fetch feedback count

  // Notifications and Comments
  static String getNotificationDetails(String patientId) =>
      "$baseUrl/GetNotificationDetails.php?patientId=$patientId"; // Get notification details
  static const String updateReplyStatus = "$baseUrl/UpdateReplyStatus.php"; // Update reply status
  static const String getPatientComments = "$baseUrl/getPatientComments.php"; // Get patient comments

  // Feedback and Replies
  static String getFeedbackDetails(String patientId) =>
      "$baseUrl/get_feedback_details.php?patientId=$patientId"; // Get feedback details for patient
  static const String sendDoctorReply = "$baseUrl/send_doctor_reply.php"; // Send doctor reply

  // Graph and Data Visualization
  static const String graphData = "$baseUrl/graph.php"; // Graph data

  // Profile Management
  static String getPatientDetails(String patientId) =>
      "$baseUrl/Gettingpatientdetails.php?patientId=$patientId"; // Get patient details
  static const String detailsofpatient = "$baseUrl/fetchPatientDetails.php"; // Patient details
  static const String updatePatientDetails = "$baseUrl/UpdatePatientDetails.php"; // Update patient details
  static String getDoctorDetails(String doctorId) =>
      "$baseUrl/getDoctorDetails.php?doctor_ID=$doctorId"; // Get doctor details
  static const String updateDoctorDetails = "$baseUrl/updateDoctorDetails.php"; // Update doctor details

  // Notification Count for Doctor
  static String getNotificationCountDoctor(String patientId) =>
      "$baseUrl/GetNotificationCountdoctor.php?patientId=$patientId"; // Get notification count for doctor
}
