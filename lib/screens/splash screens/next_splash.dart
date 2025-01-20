import 'package:fiixconn_social_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/splashImage.png'), // Path to your image in the assets folder
                fit: BoxFit.cover, // Make the image cover the entire screen
              ),
            ),
          ),
          // Language Dropdown and UI Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Language dropdown at the top-right
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth * 0.05, // Right padding for positioning
                    top: screenHeight * 0.02, // Top padding for safe area
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: DropdownButton<String>(
                      value: selectedLanguage, // Currently selected language
                      onChanged: (String? newLanguage) {
                        setState(() {
                          selectedLanguage = newLanguage!;
                        });
                      },
                      dropdownColor: Colors.black, // Background of dropdown
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16,
                      ),
                      items: <String>[
                        'English',
                        'French',
                        'Spanish',
                        'German',
                        'Italian'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Spacer to push content to their positions
                const Spacer(),
                // Centered logo
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/logos/logo.png"),
                    ],
                  ),
                ),
                // Spacer to position buttons correctly
                const Spacer(),
                // Buttons at the bottom center
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, // Padding for buttons
                      vertical: screenHeight * 0.05), // Bottom padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Log In button
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for Log In
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // White background
                          foregroundColor: Colors.black, // Black text
                          minimumSize:
                              Size(screenWidth * 0.35, 50), // Button size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Log In"),
                      ),
                      // Sign Up button
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for Sign Up
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue[900], // Dark blue background
                          foregroundColor: Colors.white, // White text
                          minimumSize:
                              Size(screenWidth * 0.35, 50), // Button size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
