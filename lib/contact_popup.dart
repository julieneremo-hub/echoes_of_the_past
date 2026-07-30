import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactPopup extends StatefulWidget {
  const ContactPopup({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => const ContactPopup(),
    );
  }

  @override
  State<ContactPopup> createState() => _ContactPopupState();
}

class _ContactPopupState extends State<ContactPopup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSending = true;
    });

    final String name = _nameController.text.trim();
    final String userEmail = _emailController.text.trim();
    final String message = _messageController.text.trim();

    try {
      // Option A: Using EmailJS (Recommended free client-side email service)
      // Replace with your EmailJS credentials or your custom backend API URL
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': 'eotp_contact',
          'template_id': 'eotp_feedback',
          'user_id': 'kyIGQ70Hja0x0-Jtt',
          'template_params': {
            'user_name': name,
            'user_email': userEmail,
            'message': message,
          }
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        Navigator.of(context).pop(); // Close popup
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully! We will get back to you soon.'),
            backgroundColor: Color(0xFFC2410C),
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        _showErrorSnackBar('Failed to send message. Please try again later.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('An error occurred while sending. Please check your network connection.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF121824);
    const Color accentColor = Color(0xFFF97316);
    const Color textColor = Colors.white;
    const Color subtitleColor = Colors.grey;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Have feedback, bugs, or inquiries?',
                        style: TextStyle(color: subtitleColor, fontSize: 13),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: subtitleColor),
                    onPressed: _isSending ? null : () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name Field
              _buildLabel('Full Name'),
              TextFormField(
                controller: _nameController,
                enabled: !_isSending,
                style: const TextStyle(color: textColor),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your name' : null,
                decoration: _inputDecoration('Enter your full name'),
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildLabel('Email Address'),
              TextFormField(
                controller: _emailController,
                enabled: !_isSending,
                style: const TextStyle(color: textColor),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                decoration: _inputDecoration('Enter your email address'),
              ),
              const SizedBox(height: 16),

              // Message Field
              _buildLabel('Message / Inquiry'),
              TextFormField(
                controller: _messageController,
                enabled: !_isSending,
                maxLines: 4,
                maxLength: 500,
                style: const TextStyle(color: textColor),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please type your message' : null,
                decoration: _inputDecoration('How can we help you?').copyWith(
                  counterStyle: const TextStyle(color: subtitleColor, fontSize: 11),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button with Loading State
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSending ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    disabledBackgroundColor: accentColor.withValues(alpha: 0.5),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isSending
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Send Message",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
      filled: true,
      fillColor: Colors.black26,
      errorStyle: const TextStyle(color: Color(0xFFFB923C)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFF97316), width: 1.5),
      ),
    );
  }
}