import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:plantsnap/Screens/login_screen.dart';
import 'package:plantsnap/Screens/menu_screen.dart';
import 'package:plantsnap/widgets/inputfield.dart';
import 'package:plantsnap/Services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  State<RegistrationScreen> createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 217),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 55), child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/PlantSnap.png',
              height: 45,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                "Lets Register Your Account!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                "Start by providing your details below.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 20),
            InputField(hintText: "Username", controller: usernameController),
            const SizedBox(height: 10),
            InputField(hintText: "Email", controller: emailController),
            const SizedBox(height: 10),
            InputField(hintText: "Password", controller: passwordController),
            const SizedBox(height: 10),
            InputField(
                hintText: "Confirm Password",
                controller: confirmpasswordController),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 243,
                height: 53,
                child: ElevatedButton(
                  onPressed: () async {
                    User? user = await firestoreService.SignUp(emailController.text, passwordController.text);
                    if(user == null){
                      print("Unable to Sign in");
                    }
                    else{
                      String uid = user.uid;
                      String email = user.email!;
                      Map<String, dynamic> newUser = {
                        "uid": user.uid,
                        "username": usernameController.text,
                        "email": emailController.text,
                        "password": passwordController.text
                      };
                      print("User ID:  $uid, Email $email");
                      firestoreService.addDocument('RegisteredUsers', newUser);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MenuScreen(currentUser: user);
                      }));
                    }
                    
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Background color
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(color: Colors.white), // Text color
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Already have an account?", style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }));
                    },
                    child: Text("Log In", style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),),
                  ),
                ],
              ),
            )
          ],
        ),),
        ),
    );
  }
}
