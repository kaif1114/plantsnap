import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String type; // Add type parameter for email, password, username, or phone

  InputField({
    required this.controller,
    required this.hintText,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  
  String? _validateInput(String? value) {
    if (widget.type == 'email') {
      // Email validation
      if (value == null || value.isEmpty) {
        return 'Please enter an email';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Please enter a valid email';
      }
    } else if (widget.type == 'password') {
      // Password validation
      if (value == null || value.isEmpty) {
        return 'Please enter a password';
      } else if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    } else if (widget.type == 'username') {
      // Username validation
      if (value == null || value.isEmpty) {
        return 'Please enter a username';
      } else if (value.length < 4) {
        return 'Username must be at least 4 characters';
      }
    } else if (widget.type == 'phone') {
      // Phone validation
      if (value == null || value.isEmpty) {
        return 'Please enter a phone number';
      } else if (!RegExp(r'^\d+$').hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: widget.controller,
      keyboardType: widget.type == 'phone' ? TextInputType.number : TextInputType.text,
      obscureText: widget.type == 'password', // Set obscureText to true for password type
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        errorStyle: TextStyle(color: Colors.redAccent),
      ),
      validator: _validateInput, // Add validator
    );
  }
}