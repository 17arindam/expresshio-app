import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKeyStudent = GlobalKey<FormState>();
  final _formKeyTeacher = GlobalKey<FormState>();

  // Student form controllers
  final _studentNameController = TextEditingController();
  final _studentAgeController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _studentPasswordController = TextEditingController();
  final _studentConfirmPasswordController = TextEditingController();
  String? _studentGender;
  String? _studentDisability;

  // Teacher form controllers
  final _teacherNameController = TextEditingController();
  final _teacherAgeController = TextEditingController();
  final _teacherExperienceController = TextEditingController();
  final _teacherEmailController = TextEditingController();
  final _teacherPasswordController = TextEditingController();
  final _teacherConfirmPasswordController = TextEditingController();
  String? _teacherGender;
  String? _teacherEducation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Clean up controllers
    _studentNameController.dispose();
    _studentAgeController.dispose();
    _studentEmailController.dispose();
    _studentPasswordController.dispose();
    _studentConfirmPasswordController.dispose();
    _teacherNameController.dispose();
    _teacherAgeController.dispose();
    _teacherExperienceController.dispose();
    _teacherEmailController.dispose();
    _teacherPasswordController.dispose();
    _teacherConfirmPasswordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _ageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    } else if (int.tryParse(value) == null) {
      return 'Please enter a valid age';
    }
    return null;
  }

  String? _experienceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your years of experience';
    } else if (int.tryParse(value) == null) {
      return 'Please enter a valid number of years';
    }
    return null;
  }

  void _registerStudent() {
    if (_formKeyStudent.currentState!.validate()) {
      // Process student registration
      print("Student Registered: ${_studentNameController.text}");
    }
  }

  void _registerTeacher() {
    if (_formKeyTeacher.currentState!.validate()) {
      // Process teacher registration
      print("Teacher Registered: ${_teacherNameController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Student'),
            Tab(text: 'Teacher'),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside form fields
        child: TabBarView(
          controller: _tabController,
          children: [
            // Student Registration Form
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKeyStudent,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _studentNameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: _nameValidator,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _studentAgeController,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: _ageValidator,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _studentGender,
                      hint: Text('Select Gender'),
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                          .toList(),
                      onChanged: (value) => setState(() => _studentGender = value),
                      validator: (value) => value == null ? 'Please select your gender' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _studentEmailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: _emailValidator,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _studentDisability,
                      hint: Text('Select Disability'),
                      items: ['Deaf', 'Mute', 'Deaf and Mute', 'Other']
                          .map((disability) => DropdownMenuItem(value: disability, child: Text(disability)))
                          .toList(),
                      onChanged: (value) => setState(() => _studentDisability = value),
                      validator: (value) => value == null ? 'Please select your disability' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _studentPasswordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: _passwordValidator,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _studentConfirmPasswordController,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) => _confirmPasswordValidator(value, _studentPasswordController.text),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _registerStudent,
                      child: Text('Register as Student'),
                    ),
                  ],
                ),
              ),
            ),

            // Teacher Registration Form
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKeyTeacher,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _teacherNameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: _nameValidator,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _teacherAgeController,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: _ageValidator,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _teacherExperienceController,
                      decoration: InputDecoration(labelText: 'Years of Experience'),
                      keyboardType: TextInputType.number,
                      validator: _experienceValidator,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _teacherGender,
                      hint: Text('Select Gender'),
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                          .toList(),
                      onChanged: (value) => setState(() => _teacherGender = value),
                      validator: (value) => value == null ? 'Please select your gender' : null,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _teacherEmailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: _emailValidator,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _teacherPasswordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: _passwordValidator,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _teacherConfirmPasswordController,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) => _confirmPasswordValidator(value, _teacherPasswordController.text),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _registerTeacher,
                      child: Text('Register as Teacher'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
