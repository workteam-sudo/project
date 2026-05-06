import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appointments.dart/appointment_service.dart';

/// Full list + add / status updates for the signed-in doctor.
class DoctorAppointmentsScreen extends StatelessWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Appointments')),
        body: const Center(child: Text('You must be signed in as a doctor.')),
      );
    }

    final svc = AppointmentService();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        title: const Text('Appointments'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddDialog(context, uid, svc),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: StreamBuilder<List<Appointment>>(
        stream: svc.watchDoctorAppointments(uid),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Could not load appointments.\n${snap.error}\n\n'
                  'Create a Firestore composite index for:\n'
                  'collection `appointments`: doctorId (Ascending) + scheduledAt (Descending)',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final list = snap.data!;
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text('No appointments yet'),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => _openAddDialog(context, uid, svc),
                    child: const Text('Add first appointment'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Newest first · ${list.length} total',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                );
              }
              final a = list[i - 1];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF2E75B6).withValues(alpha: 0.12),
                    child: const Icon(Icons.person, color: Color(0xFF2E75B6)),
                  ),
                  title: Text(
                    a.patientName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${a.dateKey} · ${a.timeLabel} · ${a.type}\n'
                    '${a.specialty.isEmpty ? '' : '${a.specialty} · '}'
                    'Status: ${a.status}',
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      try {
                        if (value == 'delete') {
                          await svc.deleteAppointment(a.id);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Appointment removed')),
                            );
                          }
                        } else {
                          await svc.updateStatus(a.id, value);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$e')),
                          );
                        }
                      }
                    },
                    itemBuilder: (ctx) => [
                      const PopupMenuItem(
                        value: 'pending',
                        child: Text('Set pending'),
                      ),
                      const PopupMenuItem(
                        value: 'confirmed',
                        child: Text('Set confirmed'),
                      ),
                      const PopupMenuItem(
                        value: 'completed',
                        child: Text('Set completed'),
                      ),
                      const PopupMenuItem(
                        value: 'cancelled',
                        child: Text('Set cancelled'),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openAddDialog(
    BuildContext context,
    String doctorId,
    AppointmentService svc,
  ) async {
    final nameCtrl = TextEditingController();
    DateTime date = DateTime.now();
    TimeOfDay time = const TimeOfDay(hour: 10, minute: 0);
    String type = 'Consultation';

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) {
          Future<void> pickDate() async {
            final d = await showDatePicker(
              context: ctx,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 1)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (d != null) setLocal(() => date = d);
          }

          Future<void> pickTime() async {
            final t = await showTimePicker(
              context: ctx,
              initialTime: time,
            );
            if (t != null) setLocal(() => time = t);
          }

          return AlertDialog(
            title: const Text('New appointment'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Patient name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: type,
                    decoration: const InputDecoration(
                      labelText: 'Visit type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Consultation', child: Text('Consultation')),
                      DropdownMenuItem(value: 'Follow-up', child: Text('Follow-up')),
                      DropdownMenuItem(value: 'Checkup', child: Text('Checkup')),
                      DropdownMenuItem(value: 'Procedure', child: Text('Procedure')),
                    ],
                    onChanged: (v) => setLocal(() => type = v ?? 'Consultation'),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Date'),
                    subtitle: Text(AppointmentService.dateKeyFor(date)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: pickDate,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Time'),
                    subtitle: Text(time.format(ctx)),
                    trailing: const Icon(Icons.schedule),
                    onTap: pickTime,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );

    if (ok != true || !context.mounted) {
      nameCtrl.dispose();
      return;
    }

    final name = nameCtrl.text.trim();
    nameCtrl.dispose();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a patient name')),
      );
      return;
    }

    final dt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    try {
      await svc.createByDoctor(
        doctorId: doctorId,
        patientName: name,
        scheduledAt: dt,
        type: type,
        status: 'confirmed',
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment saved')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    }
  }
}
