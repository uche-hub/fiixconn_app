import 'package:fiixconn_social_app/screens/video_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false; // Controls password visibility
  String? usernameError; // Error message for username validation
  String? passwordError; // Error message for password validation

  // Function to validate and login
  void validateAndLogin() {
    setState(() {
      usernameError = usernameController.text != 'kaizen_designer'
          ? 'Invalid username. Please use "kaizen_designer".'
          : null;

      passwordError = passwordController.text != 'Password@123'
          ? 'Invalid password. Please use "Password@123".'
          : null;
    });

    if (usernameError == null && passwordError == null) {
      // If no errors, login successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VideoPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back arrow at the top-left
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 40, // Width of the circle
                  height: 40, // Height of the circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Color(0xFF64748A)), // Circular border
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFF64748A)),
                    onPressed: () {
                      // Back action
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              SizedBox(height: 40), // Spacing

              // Logo in the center
              Center(
                child: Image.asset(
                  'assets/logos/logoblue.png', // Ensure the logo is in the assets folder
                  height: 100,
                ),
              ),

              SizedBox(height: 40), // Spacing

              // Username Label
              Row(
                children: [
                  Text(
                    "Username",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              // Username Input Field
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Enter the username: kaizen_designer",
                  errorText: usernameError, // Shows error if validation fails
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD0D5DD)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD0D5DD)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              SizedBox(height: 20), // Spacing

              // Password Label
              Row(
                children: [
                  Text(
                    "Password",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              // Password Input Field
              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  hintText: "Enter password: Password@123",
                  errorText: passwordError, // Shows error if validation fails
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD0D5DD)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD0D5DD)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              SizedBox(height: 30), // Spacing

              // Log In Button
              ElevatedButton(
                onPressed: validateAndLogin, // Trigger validation on click
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366), // Button color
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Log In",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15), // Spacing

              // Forgotten Password Button
              TextButton(
                onPressed: () {
                  // Forgotten password action
                },
                child: Text(
                  "Forgotten Password?",
                  style: TextStyle(color: Color(0xFF003366)),
                ),
              ),

              SizedBox(height: 180), // Spacing

              // Create New Account Button
              OutlinedButton(
                onPressed: () {
                  // Create new account action
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Color(0xFFE5E7EB),
                  ), // Border color
                  minimumSize: Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Create new account",
                  style: GoogleFonts.montserrat(color: Color(0xFF003366)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
