import 'package:flutter/material.dart';
import 'package:flutter_application_1/admissiondetail.dart/admissionpage.dart';
import 'package:flutter_application_1/app.dart/screens.dart';
import 'package:flutter_application_1/appointments.dart/bookappoint.dart';
import 'package:flutter_application_1/authentication.dart/verifycode.dart';
import 'package:flutter_application_1/appointments.dart/appointment.dart';
import 'package:flutter_application_1/appointments.dart/confirmappoint.dart';
import 'package:flutter_application_1/billinginformation.dart/billingpage.dart';
import 'package:flutter_application_1/logout.dart/logoutpage.dart';
import 'package:flutter_application_1/notifications.dart/notificationpage.dart';
import 'package:flutter_application_1/patientdash.dart/dashboard.dart';
import 'package:flutter_application_1/medicalrecords.dart/labresults.dart';
import 'package:flutter_application_1/medicalrecords.dart/medicalrecord.dart';
import 'package:flutter_application_1/medicalrecords.dart/vaccine.dart';
import 'package:flutter_application_1/medicalrecords.dart/visdetail.dart';
import 'package:flutter_application_1/prescriptions.dart/prescdetail.dart';
import 'package:flutter_application_1/prescriptions.dart/prescriptionlist.dart';
import 'package:flutter_application_1/prescriptions.dart/requestrefill.dart';
import 'package:flutter_application_1/settings.dart/settingpage.dart';
import 'authentication.dart/forgotpassword.dart';
import 'authentication.dart/newpassword.dart';

// import 'app.dart/screens.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //  implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
      routes: {
        '/forgot': (context) => Forgotpassword(),
        '/verifycode': (context) => VerifyIdentityScreen(),
        '/newpassword': (context) => CreateNewPasswordScreen(),
        '/dashboard': (context) => PatientDashboard(),
        '/appointment': (context) => MyAppointmentsScreen(),
        '/bookappoint': (context) => BookAppointmentScreen(),
        '/confirmappoint': (context) => BookingConfirmedScreen(),
        '/medicalrecord': (context) => MedicalRecordsScreen(),
        '/labresult': (context) => LabResultsScreen(),
        '/vaccine': (context) => VaccinesScreen(),
        '/visdetail': (context) => VisitDetailsScreen(),
        '/prescriptions': (context) => PrescriptionsPage(),
        '/prescdetail': (context) => PrescriptionDetailsScreen(),
        '/requestrefill': (context) => RequestRefillScreen(),
        '/admissiondetail': (context) => AdmissionDetailsPage(),
        '/billinginformation': (context) => BillingInformationPage(),
        '/notifications': (context) => NotificationsPage(),
        '/settings': (context) => AccountSettingsPage(),
        '/logout': (context) => LogoutModalDemo(),
      },
    );
  }
}
