import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appointments.dart/appointment_service.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _svc = AppointmentService();
  String? _specialty;
  String? _doctorId;
  DateTime _date = DateTime.now();
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);
  bool _saving = false;

  static const _specialties = [
    'Cardiology',
    'Orthopedics',
    'Dermatology',
    'General Practice',
  ];

  Future<String> _patientDisplayName() async {
    final u = FirebaseAuth.instance.currentUser;
    if (u == null) return 'Patient';
    if (u.displayName != null && u.displayName!.trim().isNotEmpty) {
      return u.displayName!.trim();
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(u.uid)
        .get();
    return doc.data()?['fullName'] as String? ?? u.email ?? 'Patient';
  }

  Future<void> _confirm(
    BuildContext context,
    List<DoctorOption> doctors,
  ) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to book.')),
      );
      return;
    }
    if (_specialty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a specialty.')),
      );
      return;
    }

    final doctorId = _doctorId ?? (doctors.isEmpty ? null : doctors.first.uid);
    if (doctorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No doctor available.')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final patientName = await _patientDisplayName();
      final dt = DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );
      await _svc.createByPatient(
        doctorId: doctorId,
        patientId: uid,
        patientName: patientName,
        specialty: _specialty!,
        scheduledAt: dt,
        type: 'Consultation',
      );
      if (!context.mounted) return;
      await Navigator.pushNamed(context, '/confirmappoint');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007BFF);
    const Color textDark = Color(0xFF333333);
    const Color textGrey = Color(0xFF888888);
    const Color lightGrey = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, color: Colors.grey[700], size: 20),
                  ),
                  const Spacer(),
                  const Text(
                    "Book New Appointment",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DoctorOption>>(
                future: _svc.fetchDoctors(),
                builder: (context, docSnap) {
                  if (docSnap.hasError) {
                    return Center(child: Text('${docSnap.error}'));
                  }
                  if (!docSnap.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final doctors = docSnap.data!;
                  if (doctors.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No doctors are registered yet. Ask an administrator to add doctor accounts.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  final effectiveDoctorId = _doctorId ?? doctors.first.uid;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Department",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _specialty,
                              hint: const Text(
                                "Choose a specialty",
                                style: TextStyle(color: textGrey),
                              ),
                              items: _specialties
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => setState(() => _specialty = v),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Choose Doctor",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...doctors.map(
                          (d) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () =>
                                  setState(() => _doctorId = d.uid),
                              child: _DoctorSelectCard(
                                selected: effectiveDoctorId == d.uid,
                                name: d.displayName,
                                subtitle: d.email,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Date & time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Date'),
                          subtitle: Text(AppointmentService.dateKeyFor(_date)),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (picked != null) {
                              setState(() => _date = picked);
                            }
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Time'),
                          subtitle: Text(_time.format(context)),
                          trailing: const Icon(Icons.schedule),
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime: _time,
                            );
                            if (t != null) setState(() => _time = t);
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saving
                      ? null
                      : () async {
                          final doctors = await _svc.fetchDoctors();
                          if (!context.mounted) return;
                          await _confirm(context, doctors);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Confirm Appointment",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorSelectCard extends StatelessWidget {
  const _DoctorSelectCard({
    required this.selected,
    required this.name,
    required this.subtitle,
  });

  final bool selected;
  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? const Color(0xFF007BFF) : Colors.grey[300]!,
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, color: Colors.blue[700], size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (selected) const Icon(Icons.check_circle, color: Color(0xFF007BFF)),
        ],
      ),
    );
  }
}
