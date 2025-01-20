
import 'package:fiixconn_social_app/screens/splash%20screens/next_splash.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define Animation
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Loop the animation (forward and reverse)
    _animationController.repeat(reverse: true);

    // Navigate to the next screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NextScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height and width for responsiveness
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient and lines
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8EC5FC),
                  Color.fromARGB(255, 38, 120, 192)
                ], // Gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Lines in the background
          CustomPaint(
            painter: BackgroundLinesPainter(), // Custom painter for lines
            size: MediaQuery.of(context).size,
          ),
          // Main content: Logo and text
          Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the content vertically
              children: [
                // Logo (replace with your asset if available)
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    "assets/logos/logo.png",
                    width: screenWidth *
                        0.50, // Responsive logo size (25% of screen width)
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Space below the logo

                // Main tagline text
                Text(
                  "Connect. Shop. Play.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Subtext
                Text(
                  "Earn with us",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ],
            ),
          ),
          // Footer text at the bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "All right reserved",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "(c) 2024",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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

// Custom painter to add horizontal lines to the background
class BackgroundLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1) // Faint white color for the lines
      ..strokeWidth = 1; // Line thickness

    const lineSpacing = 50.0; // Spacing between each line

    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(
          Offset(0, y), Offset(size.width, y), paint); // Horizontal line
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint since the background is static
  }
}
