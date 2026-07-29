import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPopup extends StatefulWidget {
  const ContactPopup({super.key});

  // Helper method to trigger the popup overlay
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7), // Darkened overlay
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

  // Replace this with your actual target Gmail address
  static const String targetGmail = "echoesofthepast0729@gmail.com";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String userEmail = _emailController.text.trim();
      final String message = _messageController.text.trim();

      // Encode query components to avoid malformed URI errors
      final String subject = Uri.encodeComponent("Inquiry from $name (Echoes of the Past)");
      final String body = Uri.encodeComponent(
        "Name: $name\nSender Email: $userEmail\n\nMessage:\n$message",
      );

      final Uri mailUri = Uri.parse("mailto:$targetGmail?subject=$subject&body=$body");

      try {
        final bool launched = await launchUrl(
          mailUri,
          mode: LaunchMode.externalApplication,
        );

        if (!launched && mounted) {
          _showErrorSnackBar('Could not launch email client. Please try again.');
          return;
        }

        if (mounted) {
          Navigator.of(context).pop(); // Close popup on success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Opening email app... Please send the pre-filled message.'),
              backgroundColor: Color(0xFFC2410C),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          _showErrorSnackBar('Error opening mail client: $e');
        }
      }
    }
  }

  void _showErrorSnackBar(String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF121824); // Deep dark blue/gray
    const Color accentColor = Color(0xFFF97316);     // Game orange
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
              // Header Row: Title & Close Button
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name Field
              _buildLabel('Full Name'),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: textColor),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your name' : null,
                decoration: _inputDecoration('Enter your full name'),
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildLabel('Email Address'),
              TextFormField(
                controller: _emailController,
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
                maxLines: 4,
                maxLength: 500,
                style: const TextStyle(color: textColor),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please type your message' : null,
                decoration: _inputDecoration('How can we help you?').copyWith(
                  counterStyle: const TextStyle(color: subtitleColor, fontSize: 11),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
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

  // Custom styling elements
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