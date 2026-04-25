import 'app.dart/login.dart';
import 'app.dart/signup.dart';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/admissiondetail.dart/admissionpage.dart';
import 'package:flutter_application_1/admissiondetail.dart/editprofile.dart';
import 'package:flutter_application_1/admissiondetail.dart/patientprofile.dart';
// import 'package:flutter_application_1/app.dart/screens.dart';
import 'package:flutter_application_1/appointments.dart/bookappoint.dart';
import 'package:flutter_application_1/authentication.dart/verifycode.dart';
import 'package:flutter_application_1/appointments.dart/appointment.dart';
import 'package:flutter_application_1/appointments.dart/confirmappoint.dart';
import 'package:flutter_application_1/billinginformation.dart/billingpage.dart';
import 'package:flutter_application_1/billinginformation.dart/comppayment.dart';
import 'package:flutter_application_1/billinginformation.dart/paymentdetails.dart';
import 'package:flutter_application_1/billinginformation.dart/paymentmethod.dart';
import 'package:flutter_application_1/billinginformation.dart/sendreminder.dart';
import 'package:flutter_application_1/billinginformation.dart/viewdetails.dart';
import 'package:flutter_application_1/billinginformation.dart/viewreceipt.dart';
import 'package:flutter_application_1/billinginformation.dart/viewschedule.dart';
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
        '/signup': (context) => SignupPage(),
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
        '/patientprofile': (context) => PatientProfileScreen(),
        '/editprofile': (context) => EditProfileScreen(),
        '/billinginformation': (context) => BillingInformationPage(),
        '/viewdetails': (context) => InvoiceDetailsScreen(),
        '/paymentmethod': (context) => PaymentMethodScreen(),
        '/paymentdetails': (context) => PaymentDetailsScreen(),
        '/comppayment': (context) => PaymentProcessingScreen(),
        '/viewreceipt': (context) => ReceiptDetailsScreen(),
        '/sendreminder': (context) => SendReminderScreen1(),
        '/viewschedule': (context) => ReviewScheduleScreen(),
        '/notifications': (context) => NotificationsPage(),
        '/settings': (context) => AccountSettingsPage(),
        '/logout': (context) => LogoutModalDemo(),
      },
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital, size: 100, color: Colors.teal),
                    SizedBox(height: 20),
                    Text(
                      "Hospital Management System",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 20, color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
