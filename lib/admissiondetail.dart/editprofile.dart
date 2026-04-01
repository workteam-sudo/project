import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController(
    text: 'Alexander Thompson',
  );
  final TextEditingController _dobController = TextEditingController(
    text: '05/12/1989',
  );
  final TextEditingController _occupationController = TextEditingController(
    text: 'Software Engineer',
  );
  final TextEditingController _emergencyNameController = TextEditingController(
    text: 'Eleanor Thompson',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+1 (555) 012-3456',
  );
  final TextEditingController _addressController = TextEditingController(
    text: '452 Oak Street, Seattle, WA',
  );

  String _selectedGender = 'Male';
  String _selectedMaritalStatus = 'Married';
  String _selectedRelationship = 'Spouse';

  final List<String> _allergies = ['Peanuts', 'Latex'];
  final TextEditingController _allergyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.blue.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop',
                        ),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Personal Information Section
              _buildSectionTitle('Personal Information'),
              _buildTextField('Full Name', _nameController),
              _buildTextField(
                'Date of Birth',
                _dobController,
                keyboardType: TextInputType.datetime,
              ),
              _buildDropdownField(
                'Gender',
                _selectedGender,
                ['Male', 'Female', 'Other'],
                (value) {
                  setState(() => _selectedGender = value!);
                },
              ),
              _buildTextField('Occupation', _occupationController),
              _buildDropdownField(
                'Marital Status',
                _selectedMaritalStatus,
                ['Single', 'Married', 'Divorced', 'Widowed'],
                (value) {
                  setState(() => _selectedMaritalStatus = value!);
                },
              ),

              SizedBox(height: 30),

              // Known Allergies Section
              _buildSectionTitle('Known Allergies'),
              _buildAllergiesSection(),

              SizedBox(height: 30),

              // Emergency Contact Section
              _buildSectionTitle('Emergency Contact'),
              _buildTextField('Name', _emergencyNameController),
              _buildTextField(
                'Relationship',
                null,
                // controller: null,
                value: _selectedRelationship,
                dropdownItems: [
                  'Spouse',
                  'Parent',
                  'Sibling',
                  'Friend',
                  'Other',
                ],
                onChanged: (value) =>
                    setState(() => _selectedRelationship = value!),
              ),
              _buildTextField(
                'Phone Number',
                _phoneController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField('Address', _addressController, maxLines: 2),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController? controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? value,
    List<String>? dropdownItems,
    ValueChanged<String?>? onChanged,
  }) {
    if (dropdownItems != null) {
      return _buildDropdownField(label, value ?? '', dropdownItems, onChanged!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAllergiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Allergies',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allergies.map((allergy) {
                  return Chip(
                    label: Text(allergy),
                    backgroundColor: Colors.red.shade100,
                    deleteIcon: Icon(Icons.close, size: 18),
                    onDeleted: () => setState(() {
                      _allergies.remove(allergy);
                    }),
                  );
                }).toList(),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _allergyController,
                      decoration: InputDecoration(
                        hintText: 'Add new allergy',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red.shade200),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: _addAllergy,
                    icon: Icon(Icons.add, color: Colors.red.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _addAllergy() {
    if (_allergyController.text.isNotEmpty) {
      setState(() {
        _allergies.add(_allergyController.text);
        _allergyController.clear();
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile saved successfully!')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _occupationController.dispose();
    _emergencyNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _allergyController.dispose();
    super.dispose();
  }
}
