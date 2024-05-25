import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.black), // Background color
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(color: Colors.white), // Text color
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/PlantSnap.png',
                height: 55,
              ),
              const SizedBox(height: 20),
              Text(
                'Your own plant encyclopedia',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Image.asset(
                'assets/images/plant.png',
                height: 361,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 210,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  },
                  style: buttonStyle,
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.lato(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70,),
              Align(
                child: Text("Developed by Kaif and Alishba.", style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w600),),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
      ),
    );
  }
}
