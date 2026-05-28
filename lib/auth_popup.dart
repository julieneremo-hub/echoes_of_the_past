import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthPopup extends StatefulWidget {
  const AuthPopup({super.key});

  @override
  State<AuthPopup> createState() => _AuthPopupState();
}

class _AuthPopupState extends State<AuthPopup> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  bool isLogin = true;
  bool isLoading = false;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final Color bgColor = const Color(0xFF121826);
  final Color fieldColor = const Color(0xFF1F2937);
  final Color accentColor = const Color(0xFFE68A00);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    return null;
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        if (isLogin) {
          await _authService.signIn(_userController.text.trim(), _passController.text);
        } else {
          await _authService.signUp(
            _emailController.text.trim(), 
            _passController.text, 
            _userController.text.trim()
          );
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.redAccent),
        );
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get the current screen width using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: bgColor,
      // 2. Adjust margin when screen is minimized so it doesn't touch the edges completely
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(32),
        // 3. Make width dynamic: 90% of screen on tiny displays, max 450px on desktop
        width: screenWidth < 500 ? screenWidth * 0.9 : 450,
        child: Form(
          key: _formKey,
          // 4. Wrapped in SingleChildScrollView so fields aren't crushed on ultra-small screens
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        isLogin ? "Welcome Back" : "Join the Revolution",
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // Safe text scaling
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  isLogin ? "Login to continue your journey" : "Create your account to begin",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 32),
                
                _buildLabel(isLogin ? "Username or Email" : "Username"),
                _buildTextField(_userController, "Enter details", validator: _validateUsername),
                
                if (!isLogin) ...[
                  const SizedBox(height: 20),
                  _buildLabel("Email"),
                  _buildTextField(_emailController, "Enter your email", validator: _validateEmail),
                ],
                
                const SizedBox(height: 20),
                _buildLabel("Password"),
                _buildTextField(_passController, "Enter password", isPass: true, validator: _validatePassword),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: isLoading ? null : _handleSubmit,
                    child: isLoading 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : Text(isLogin ? "Login" : "Create Account", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _formKey.currentState?.reset();
                      setState(() => isLogin = !isLogin);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: isLogin ? "Don't have an account? " : "Already have an account? ",
                        style: const TextStyle(color: Colors.white70),
                        children: [
                          TextSpan(
                            text: isLogin ? "Register here" : "Login here",
                            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPass = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: isPass,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: fieldColor,
        errorStyle: const TextStyle(color: Colors.redAccent),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: accentColor)),
      ),
    );
  }
}