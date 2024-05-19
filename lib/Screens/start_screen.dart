import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/login_screen.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         backgroundColor: const Color.fromARGB(255, 237, 237, 217),
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           background: const Color.fromARGB(255, 237, 237, 217),
//         ),
//       ),
//       home: MyApp(),
//     ),
//   );
// }

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
              const SizedBox(height: 70),
              Image.asset(
                'assets/images/PlantSnap.png',
                height: 65,
              ),
              const SizedBox(height: 25),
              Text(
                'Your own plant encyclopedia',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Image.asset(
                'assets/images/plant.png',
                height: 391,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 240,
                height: 60,
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
              const SizedBox(height: 50,),
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
