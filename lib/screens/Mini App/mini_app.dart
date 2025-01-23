import 'package:flutter/material.dart';

class MiniAppsScreen extends StatefulWidget {
  @override
  _MiniAppsScreen createState() => _MiniAppsScreen();
}

class _MiniAppsScreen extends State<MiniAppsScreen> {
  bool isDarkTheme = true; // Tracks the current theme

  @override
  Widget build(BuildContext context) {
    // Define a custom order for the games
    List<int> customOrder = [2, 4, 3, 1, 5];

    return Scaffold(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First View: Background with top bar
            Stack(
              children: [
                // Background Image
                Container(
                  height:
                      MediaQuery.of(context).size.height, // Full screen height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/bg.png'), // Replace with your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Top Bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Arrow
                        CircleAvatar(
                          radius: 20, // Adjust size as needed
                          backgroundColor:
                              Colors.transparent, // No background color
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkTheme
                                    ? Colors.white
                                    : Colors.black, // Border color
                                width: 2, // Border thickness
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: isDarkTheme
                                  ? Colors.white
                                  : Colors.black, // Icon color
                            ),
                          ),
                        ),
                        // Title
                        Text(
                          "Mini Apps",
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Icons: Search, Award, Profile
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: isDarkTheme ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 16),
                            Image.asset(
                              "assets/icons/ranking.png",
                              color: isDarkTheme ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDarkTheme = !isDarkTheme; // Toggle theme
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: isDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                        width: 3),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/icons/mini_profile.png',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Second View: Content
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trending Section
                  Text(
                    "Trending",
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Trending games from 30 days",
                    style: TextStyle(
                      color: isDarkTheme
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/game${index + 1}.png', // Update the file names as per your assets
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Game ${index + 1}",
                                style: TextStyle(
                                  color:
                                      isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Categories Section
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  // Image Container
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/cat_game${index + 1}.png', // Replace with your actual image file paths
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Text Details
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Game ${index + 1}",
                                        style: TextStyle(
                                          color: isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Hello game",
                                        style: TextStyle(
                                          color: isDarkTheme
                                              ? Colors.white.withOpacity(0.7)
                                              : Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          width: 230,
                        ),
                        // Overflow Content
                        Column(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  // Image Container
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/cat_game${index + 4}.png', // Replace with your actual image file paths
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Text Details
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Game ${index + 4}",
                                        style: TextStyle(
                                          color: isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Hello game",
                                        style: TextStyle(
                                          color: isDarkTheme
                                              ? Colors.white.withOpacity(0.7)
                                              : Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  // Recently Opened Section
                  Text(
                    "Recently Opened",
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Here are some of your recently played games",
                    style: TextStyle(
                      color: isDarkTheme
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        int gameNumber = customOrder[
                            index]; // Get the game number based on the custom order
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/game$gameNumber.png', // Replace with your image file names
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Game $gameNumber",
                                style: TextStyle(
                                  color:
                                      isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
