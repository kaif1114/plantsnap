import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/menu_screen.dart';
import 'package:plantsnap/Screens/registration_screen.dart';
import 'package:plantsnap/widgets/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plantsnap/Services/firestore_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool invalidLogin = false;
  void handleInvalidLogin() {
    setState(() {
      invalidLogin = true;
    });
  }

  final fireStoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 65),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/PlantSnap.png',
                height: 45.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Lets sign you in',
                style: GoogleFonts.lato(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                'Welcome Back,',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'You have been missed',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              invalidLogin
                  ? Center(
                      child: Text(
                        "Invalid login Details",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 37, 21)),
                      ),
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              const SizedBox(height: 15.0),
              MyForm(
                onInvalidLogin: handleInvalidLogin,
              ),
              const SizedBox(height: 3.0),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {}, // Add functionality for forgot password
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password?',
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 3.0),
              const SizedBox(height: 20.0),
              Image.asset('assets/images/or-bar.png'),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t Have Account?',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegistrationScreen();
                      }));
                    }, // Add navigation to register page
                    child: Text(
                      'Register Now',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  MyForm({super.key, required this.onInvalidLogin});

  final Function onInvalidLogin;

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  FirestoreService fireStoreService = FirestoreService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleSubmit() async {
    User? user = await fireStoreService.SignIn(
        emailController.text, passwordController.text);
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MenuScreen(
          currentUser: user,
        );
      }));
    } else {
      widget.onInvalidLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputField(
            controller: emailController,
            hintText: 'Enter your email',
            type: 'email',
          ),
          SizedBox(height: 12),
          InputField(
            controller: passwordController,
            hintText: 'Enter your password',
            type: 'password',
          ),
          SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 210,
              height: 49,
              child: ElevatedButton(
                onPressed: handleSubmit,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Background color
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Colors.white), // Text color
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
