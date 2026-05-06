import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore-backed appointment for doctor / patient flows.
///
/// Collection: `appointments`
/// Fields: `doctorId`, `patientId`, `patientName`, `specialty`, `scheduledAt`,
/// `dateKey` (yyyy-MM-dd local), `type`, `status`, `createdAt`
class Appointment {
  const Appointment({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.patientName,
    required this.specialty,
    required this.scheduledAt,
    required this.dateKey,
    required this.type,
    required this.status,
  });

  final String id;
  final String doctorId;
  final String patientId;
  final String patientName;
  final String specialty;
  final DateTime scheduledAt;
  final String dateKey;
  final String type;
  final String status;

  static Appointment fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final ts = data['scheduledAt'] as Timestamp?;
    final at = ts?.toDate() ?? DateTime.now();
    return Appointment(
      id: doc.id,
      doctorId: data['doctorId'] as String? ?? '',
      patientId: data['patientId'] as String? ?? '',
      patientName: data['patientName'] as String? ?? 'Patient',
      specialty: data['specialty'] as String? ?? '',
      scheduledAt: at,
      dateKey: data['dateKey'] as String? ?? AppointmentService.dateKeyFor(at),
      type: data['type'] as String? ?? 'Consultation',
      status: data['status'] as String? ?? 'pending',
    );
  }

  String get timeLabel {
    final h = scheduledAt.hour;
    final m = scheduledAt.minute;
    final ap = h >= 12 ? 'PM' : 'AM';
    final hh = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '${hh.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')} $ap';
  }
}

class AppointmentService {
  AppointmentService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  static String dateKeyFor(DateTime d) {
    final l = d.toLocal();
    return '${l.year}-${l.month.toString().padLeft(2, '0')}-${l.day.toString().padLeft(2, '0')}';
  }

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('appointments');

  /// Recent appointments for a doctor (ordered newest first by scheduled time).
  Stream<List<Appointment>> watchDoctorAppointments(String doctorId) {
    return _col
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('scheduledAt', descending: true)
        .limit(120)
        .snapshots()
        .map((s) => s.docs.map(Appointment.fromDoc).toList());
  }

  static List<Appointment> todayForDoctor(
    List<Appointment> all,
    String doctorId,
  ) {
    final key = dateKeyFor(DateTime.now());
    final list = all
        .where((a) => a.doctorId == doctorId && a.dateKey == key)
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return list;
  }

  static int pendingCountForDoctor(List<Appointment> all, String doctorId) {
    final start = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return all
        .where(
          (a) =>
              a.doctorId == doctorId &&
              a.status == 'pending' &&
              !a.scheduledAt.isBefore(start),
        )
        .length;
  }

  static int todayCountForDoctor(List<Appointment> all, String doctorId) {
    final key = dateKeyFor(DateTime.now());
    return all.where((a) => a.doctorId == doctorId && a.dateKey == key).length;
  }

  Future<DocumentReference<Map<String, dynamic>>> createByPatient({
    required String doctorId,
    required String patientId,
    required String patientName,
    required String specialty,
    required DateTime scheduledAt,
    String type = 'Consultation',
  }) {
    final at = scheduledAt.toLocal();
    return _col.add({
      'doctorId': doctorId,
      'patientId': patientId,
      'patientName': patientName,
      'specialty': specialty,
      'scheduledAt': Timestamp.fromDate(at),
      'dateKey': dateKeyFor(at),
      'type': type,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> createByDoctor({
    required String doctorId,
    required String patientName,
    required DateTime scheduledAt,
    required String type,
    String status = 'confirmed',
    String specialty = '',
    String patientId = '',
  }) {
    final at = scheduledAt.toLocal();
    return _col.add({
      'doctorId': doctorId,
      'patientId': patientId,
      'patientName': patientName.trim(),
      'specialty': specialty,
      'scheduledAt': Timestamp.fromDate(at),
      'dateKey': dateKeyFor(at),
      'type': type,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateStatus(String appointmentId, String status) {
    return _col.doc(appointmentId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteAppointment(String appointmentId) {
    return _col.doc(appointmentId).delete();
  }

  /// Patient: upcoming appointments for the signed-in user.
  Stream<List<Appointment>> watchPatientAppointments(String patientId) {
    return _col
        .where('patientId', isEqualTo: patientId)
        .orderBy('scheduledAt', descending: true)
        .limit(60)
        .snapshots()
        .map((s) => s.docs.map(Appointment.fromDoc).toList());
  }

  /// Load doctor profiles for booking (`users` where `role` == `doctor`).
  Future<List<DoctorOption>> fetchDoctors() async {
    final snap = await _db
        .collection('users')
        .where('role', isEqualTo: 'doctor')
        .limit(30)
        .get();
    return snap.docs.map(DoctorOption.fromDoc).toList();
  }
}

class DoctorOption {
  const DoctorOption({
    required this.uid,
    required this.fullName,
    required this.email,
  });

  final String uid;
  final String fullName;
  final String email;

  static DoctorOption fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return DoctorOption(
      uid: doc.id,
      fullName: data['fullName'] as String? ?? 'Doctor',
      email: data['email'] as String? ?? '',
    );
  }

  String get displayName {
    final n = fullName.trim();
    if (n.toLowerCase().startsWith('dr')) return n;
    return 'Dr. $n';
  }
}
