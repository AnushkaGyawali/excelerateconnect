import 'package:flutter/material.dart';
import '../models/program.dart';
import '../theme/app_theme.dart';
import '../services/enrollment_service.dart';
import '../widgets/success_modal.dart';
import 'profile/my_programs_screen.dart';

class RegistrationForm extends StatefulWidget {
  final Program program;

  const RegistrationForm({super.key, required this.program});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  bool _isLoading = false;
  bool _agreeToTerms = false;
  bool _receiveUpdates = true;
  String _selectedPaymentMethod = 'card';
  String? _selectedEducationLevel;

  // Education level options
  final List<String> _educationLevels = [
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctorate',
    'Other'
  ];

  // Name validation
  String? _validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    // Check for minimum length
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    // Check for maximum length
    if (value.trim().length > 50) {
      return '$fieldName cannot exceed 50 characters';
    }

    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    final nameRegex = RegExp(r"^[a-zA-ZÀ-ÿ\s'-]+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }

    // Check for consecutive special characters
    final invalidPattern = RegExp(r"[\s'-]{2,}");
    if (invalidPattern.hasMatch(value.trim())) {
      return '$fieldName contains invalid character sequences';
    }

    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final trimmedValue = value.trim();

    // Basic email format validation
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Enter a valid email address (e.g., name@example.com)';
    }

    // Check for common invalid patterns
    if (trimmedValue.contains('..')) {
      return 'Email cannot contain consecutive dots';
    }

    if (trimmedValue.startsWith('.') || trimmedValue.endsWith('.')) {
      return 'Email cannot start or end with a dot';
    }

    // Check for valid domain
    final domainPart = trimmedValue.split('@').last;
    if (domainPart.length < 4) {
      return 'Invalid domain name';
    }

    return null;
  }

  // Phone number validation
  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final cleanedValue = value.replaceAll(RegExp(r'[\s\-()+.]+'), '');

    // Check if it's all numbers
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanedValue)) {
      return 'Phone number can only contain digits and common separators';
    }

    // Check length based on international standards
    if (cleanedValue.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (cleanedValue.length > 12) {
      return 'Phone number cannot exceed 12 digits';
    }

    // Check for country code (optional)
    if (cleanedValue.startsWith('0') && cleanedValue.length > 11) {
      return 'Invalid phone number format';
    }

    return null;
  }

  // Address validation
  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }

    final trimmedValue = value.trim();

    // Check minimum length
    if (trimmedValue.length < 5) {
      return 'Address is too short';
    }

    // Check maximum length
    if (trimmedValue.length > 200) {
      return 'Address cannot exceed 200 characters';
    }

    // Check for valid address characters
    final addressRegex = RegExp(r'^[a-zA-Z0-9\s\-,.#/]+$');
    if (!addressRegex.hasMatch(trimmedValue)) {
      return 'Address contains invalid characters';
    }

    // Check for at least one number in address
    if (!RegExp(r'\d').hasMatch(trimmedValue)) {
      return 'Address should include building/house number';
    }

    return null;
  }

  // City validation
  String? _validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 2) {
      return 'City name must be at least 2 characters';
    }

    if (trimmedValue.length > 100) {
      return 'City name cannot exceed 100 characters';
    }

    final cityRegex = RegExp(r"^[a-zA-ZÀ-ÿ\s'-]+$");
    if (!cityRegex.hasMatch(trimmedValue)) {
      return 'City name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  // State validation
  String? _validateState(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'State/Province is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 2) {
      return 'State/Province must be at least 2 characters';
    }

    if (trimmedValue.length > 50) {
      return 'State/Province cannot exceed 50 characters';
    }

    final stateRegex = RegExp(r"^[a-zA-ZÀ-ÿ\s\-]+$");
    if (!stateRegex.hasMatch(trimmedValue)) {
      return 'State/Province can only contain letters, spaces, and hyphens';
    }

    return null;
  }

  // ZIP/Postal code validation
  String? _validateZip(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'ZIP/Postal code is required';
    }

    final trimmedValue = value.trim();

    // Check length
    if (trimmedValue.length < 4) {
      return 'ZIP/Postal code must be at least 4 characters';
    }

    if (trimmedValue.length > 10) {
      return 'ZIP/Postal code cannot exceed 10 characters';
    }

    // Accept alphanumeric for international postal codes
    final zipRegex = RegExp(r'^[a-zA-Z0-9\s\-]+$');
    if (!zipRegex.hasMatch(trimmedValue)) {
      return 'ZIP/Postal code can only contain letters, numbers, spaces, and hyphens';
    }

    return null;
  }

  // Education level validation
  String? _validateEducationLevel(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select your education level';
    }
    return null;
  }

  // Form submission with validation
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      // Scroll to first error if any
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final focusedField = FocusScope.of(context);
        if (!focusedField.hasPrimaryFocus) {
          focusedField.unfocus();
        }
      });
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Scroll to terms checkbox
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });

      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call for registration and payment
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Enroll in the program
    EnrollmentService().enrollInProgram(widget.program);

    // Show success modal
    _showSuccessModal();
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessModal(
        programTitle: widget.program.title,
        onStartLearning: () {
          Navigator.pop(context); // Close modal
          Navigator.pop(context); // Close registration form
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MyProgramsScreen(),
            ),
          );
        },
        onClose: () {
          Navigator.pop(context); // Close modal
          Navigator.pop(context); // Close registration form
          Navigator.pop(context); // Go back to program details
        },
      ),
    );
  }

  Widget _buildProgramSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.program.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.program.provider,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Duration:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSoft,
                  ),
                ),
                Text(
                  widget.program.duration,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Level:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSoft,
                  ),
                ),
                Text(
                  widget.program.level,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSoft,
                  ),
                ),
                Text(
                  widget.program.price,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildPaymentOption(
              icon: Icons.credit_card,
              label: 'Credit/Debit Card',
              value: 'card',
            ),
            _buildPaymentOption(
              icon: Icons.paypal,
              label: 'PayPal',
              value: 'paypal',
            ),
            _buildPaymentOption(
              icon: Icons.account_balance,
              label: 'Bank Transfer',
              value: 'bank',
            ),
            _buildPaymentOption(
              icon: Icons.wallet,
              label: 'Digital Wallet',
              value: 'wallet',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isSelected = _selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? AppTheme.primary.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primary : Colors.grey[700],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? AppTheme.primary : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Registration'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Program Summary
            _buildProgramSummary(),
            const SizedBox(height: 24),

            // Form Title
            const Text(
              'Complete Your Registration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in your details and complete payment to enroll in this course',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSoft,
              ),
            ),
            const SizedBox(height: 24),

            // Registration Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  _buildSectionHeader('Personal Information'),

                  // First & Last Name Row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name *',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                            hintText: 'Enter your first name',
                          ),
                          validator: (value) =>
                              _validateName(value, 'First name'),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name *',
                            border: OutlineInputBorder(),
                            hintText: 'Enter your last name',
                          ),
                          validator: (value) =>
                              _validateName(value, 'Last name'),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Contact Information Section
                  _buildSectionHeader('Contact Information'),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address *',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                      hintText: 'you@example.com',
                      helperText: 'We\'ll send confirmation to this email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(),
                      hintText: '(123) 456-7890',
                      helperText: 'Enter your 10-15 digit phone number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: _validatePhone,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 16),

                  // Education Level Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedEducationLevel,
                    decoration: const InputDecoration(
                      labelText: 'Highest Education Level *',
                      prefixIcon: Icon(Icons.school_outlined),
                      border: OutlineInputBorder(),
                    ),
                    items: _educationLevels
                        .map((level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedEducationLevel = value;
                      });
                    },
                    validator: _validateEducationLevel,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hint: const Text('Select your education level'),
                  ),
                  const SizedBox(height: 24),

                  // Address Information Section
                  _buildSectionHeader('Address Information'),

                  // Street Address
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Street Address *',
                      prefixIcon: Icon(Icons.home_outlined),
                      border: OutlineInputBorder(),
                      hintText: '123 Main St, Apt 4B',
                      helperText: 'Include building/house number',
                    ),
                    validator: _validateAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 16),

                  // City, State, ZIP Row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            labelText: 'City *',
                            border: OutlineInputBorder(),
                            hintText: 'New York',
                          ),
                          validator: _validateCity,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _stateController,
                          decoration: const InputDecoration(
                            labelText: 'State/Province *',
                            border: OutlineInputBorder(),
                            hintText: 'NY',
                          ),
                          validator: _validateState,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _zipController,
                          decoration: const InputDecoration(
                            labelText: 'ZIP/Postal *',
                            border: OutlineInputBorder(),
                            hintText: '10001',
                          ),
                          keyboardType: TextInputType.text,
                          validator: _validateZip,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Payment Method
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 24),

                  // Preferences Section
                  _buildSectionHeader('Preferences'),

                  // Receive Updates Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _receiveUpdates,
                        onChanged: (value) {
                          setState(() {
                            _receiveUpdates = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Receive course updates, announcements, and promotional offers',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Terms and Conditions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSoft,
                            ),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '. I understand that this is a non-refundable purchase.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  _buildSubmitButton(),

                  // Cancel Button
                  _buildCancelButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDark,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const Text(
            '* Required fields',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: AppTheme.primary.withOpacity(0.3),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Complete Enrollment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: const Text(
          'Cancel Registration',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSoft,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
