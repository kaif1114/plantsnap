import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatefulWidget{
  const InputField({super.key, required this.hintText, required this.controller});

  final String hintText;
  final TextEditingController controller;
  State<InputField> createState(){
    return InputFieldState();
  }
}

class InputFieldState extends State<InputField>{
  @override 
  Widget build(BuildContext context){
    return TextField(
              textAlign: TextAlign.start,
              controller: widget.controller,
              decoration:  InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.inter(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w400, fontSize: 15),
                filled: true,               
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              ),
            );
  }
}