import 'package:flutter/material.dart';

class NewEntryScreen extends StatefulWidget {
  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  String selectedCategory = 'Note';
  bool hasFile = false;
  DateTime selectedDate = DateTime(2023, 11, 24);
  TimeOfDay selectedTime = TimeOfDay(hour: 14, minute: 30);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract patient data from arguments
    final Map<String, dynamic>? patientData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final patientName = patientData?['fullName'] ?? patientData?['name'] ?? 'Elena Rossi';

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Hospital System',
          style: TextStyle(
            color: Color(0xFF3A7BFF),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text(
              'Patient: $patientName',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[300]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            SizedBox(height: 32),
            _buildCategorySection(),
            SizedBox(height: 32),
            _buildDynamicDetailsSection(),
            SizedBox(height: 32),
            _buildDateTimeSection(),
            SizedBox(height: 32),
            _buildKeyFindingsSection(),
            _buildFileAttachmentSection(),
            SizedBox(height: 40),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicDetailsSection() {
    String title = '';
    String hint = '';
    IconData icon = Icons.edit_note;

    switch (selectedCategory) {
      case 'Note':
        title = 'NOTE SUBJECT';
        hint = 'e.g., General Observation';
        icon = Icons.subject;
        break;
      case 'Lab':
        title = 'LAB TEST NAME';
        hint = 'e.g., Blood Glucose Level';
        icon = Icons.biotech;
        break;
      case 'Visit':
        title = 'VISIT REASON';
        hint = 'e.g., Follow-up Appointment';
        icon = Icons.meeting_room;
        break;
      case 'File':
        title = 'DOCUMENT TITLE';
        hint = 'e.g., Medical Certificate';
        icon = Icons.description;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Viewing recent ${selectedCategory}s...')),
                );
              },
              icon: Icon(Icons.history, size: 16, color: Color(0xFF3A7BFF)),
              label: Text(
                'Recent',
                style: TextStyle(color: Color(0xFF3A7BFF), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF3A7BFF), size: 24),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Entry',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Append findings to the clinical timeline.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CATEGORY',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryButton(
              icon: Icons.description_outlined,
              label: 'Note',
              isSelected: selectedCategory == 'Note',
            ),
            _buildCategoryButton(
              icon: Icons.science_outlined,
              label: 'Lab',
              isSelected: selectedCategory == 'Lab',
            ),
            _buildCategoryButton(
              icon: Icons.medical_information_outlined,
              label: 'Visit',
              isSelected: selectedCategory == 'Visit',
            ),
            _buildCategoryButton(
              icon: Icons.attach_file_outlined,
              label: 'File',
              isSelected: selectedCategory == 'File',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryButton({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE3F2FD) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFF3A7BFF) : Colors.grey[500],
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Color(0xFF3A7BFF) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DATE & TIME',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                Icons.calendar_today_outlined,
                onTap: () => _selectDate(context),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                selectedTime.format(context),
                Icons.access_time_outlined,
                onTap: () => _selectTime(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField(String value, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(icon, color: Colors.grey[500], size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyFindingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KEY FINDINGS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Brief clinical summary…',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILE ATTACHMENT',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              hasFile = !hasFile;
            });
            if (hasFile) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('File attached: report_v1.pdf')),
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  hasFile ? Icons.insert_drive_file : Icons.attach_file_outlined,
                  color: hasFile ? Color(0xFF3A7BFF) : Colors.grey[500],
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    hasFile ? 'report_v1.pdf' : 'No files attached',
                    style: TextStyle(
                      fontSize: 16,
                      color: hasFile ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                ),
                Text(
                  hasFile ? 'Remove' : 'Add File',
                  style: TextStyle(
                    color: hasFile ? Colors.red : Color(0xFF3A7BFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3A7BFF), Color(0xFF5A9BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3A7BFF).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$selectedCategory entry saved successfully')),
            );
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Save Entry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
