import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final List<Map<String, String>> externalVideos = [
    {
      'url':
          'http://videos.pexels.com/video-files/4057322/4057322-sd_506_960_25fps.mp4',
      'text':
          'The ancient forest stretched endlessly across the horizon, its towering trees cloaked in emerald-green moss and tangled vines that shimmered faintly with the morning dew.',
    },
    {
      'url':
          'http://videos.pexels.com/video-files/4058084/4058084-sd_506_960_25fps.mp4',
      'text':
          'The ancient forest stretched endlessly across the horizon, its towering trees cloaked in emerald-green moss and tangled vines that shimmered faintly with the morning dew.',
    },
    {
      'url':
          'http://videos.pexels.com/video-files/3959544/3959544-sd_506_960_25fps.mp4',
      'text':
          'The ancient forest stretched endlessly across the horizon, its towering trees cloaked in emerald-green moss and tangled vines that shimmered faintly with the morning dew.',
    },
    {
      'url':
          'http://videos.pexels.com/video-files/4038571/4038571-sd_506_960_25fps.mp4',
      'text':
          'The ancient forest stretched endlessly across the horizon, its towering trees cloaked in emerald-green moss and tangled vines that shimmered faintly with the morning dew.',
    },
    {
      'url':
          'http://videos.pexels.com/video-files/5595352/5595352-sd_360_640_24fps.mp4',
      'text':
          'The ancient forest stretched endlessly across the horizon, its towering trees cloaked in emerald-green moss and tangled vines that shimmered faintly with the morning dew.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LIVE", style: TextStyle(color: Colors.grey, fontSize: 16)),
            SizedBox(width: 16),
            Text("Following",
                style: TextStyle(color: Colors.grey, fontSize: 16)),
            SizedBox(width: 16),
            Column(
              children: [
                Text("For You",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Container(
                  height: 2,
                  width: 20,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search animation logic here
            },
          )
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: externalVideos.length,
        itemBuilder: (context, index) {
          return VideoCard(
              videoUrl: externalVideos[index]['url']!,
              text: externalVideos[index]['text']!);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/layer.png"), label: "Mini Apps"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/chat-1.png"), label: "Messages"),
          BottomNavigationBarItem(
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[900]!, width: 2),
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/notification.png"),
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/profile.png"), label: "Profile"),
        ],
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final String videoUrl;
  final String text; // Add text property

  VideoCard({required this.videoUrl, required this.text});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _showHeart = false; // Flag for showing the heart animation
  int _likeCount = 1200; // Initial like count
  bool _showDropdown = false; // Dropdown visibility toggle

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network(widget.videoUrl) // Changed to `network`
          ..initialize().then((_) {
            setState(() {
              _controller.play();
            });
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to handle double-tap for liking the video
  void _onDoubleTap() {
    setState(() {
      _likeCount++; // Increment like count
      _showHeart = true; // Show heart animation

      // Hide the heart after 1 second
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showHeart = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Limit for collapsed text
    const int textLimit = 30;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // Toggle video play/pause
            setState(() {
              if (_isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
              _isPlaying = !_isPlaying;
            });
          },
          onDoubleTap: _onDoubleTap, // Handle double-tap for liking
          child: VideoPlayer(_controller),
        ),
        // Heart animation on double-tap
        if (_showHeart)
          Center(
            child: Icon(Icons.favorite, color: Colors.red, size: 100),
          ),
        // UI elements like likes, comments, and shares
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/image.jpeg',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 40,
                ),
                Text("$_likeCount",
                    style:
                        TextStyle(color: Colors.white)), // Updated like count
                SizedBox(height: 20),
                Icon(
                  Icons.chat_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                Text("17", style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
                Icon(
                  Icons.bookmark_outline,
                  color: Colors.white,
                  size: 40,
                ),
                Text("12", style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
                Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                Text("24", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Toggle dropdown visibility
                    setState(() {
                      _showDropdown = !_showDropdown;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A), // Background color
                      borderRadius:
                          BorderRadius.circular(12), // Rounded background
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6), // Padding inside the container
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Wrap content
                      children: [
                        Image.asset(
                          "assets/icons/shop.png",
                        ), // Shop icon
                        SizedBox(width: 4),
                        Text("Shop",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                            )),
                        SizedBox(width: 4),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Color(0xFFffffff), // Dot background color
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text("4",
                            style: GoogleFonts.montserrat(color: Colors.white)),
                        SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down, // Down arrow icon
                          color: Colors.white,
                          size: 16, // Adjust size to match design
                        ),
                      ],
                    ),
                  ),
                ),
                // Dropdown menu
                if (_showDropdown)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    color: Color(0xFF1A1A1A), // Dropdown background color
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min, // Wrap content
                          children: [
                            Text("Shop",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                )),
                            SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color:
                                    Color(0xFFffffff), // Dot background color
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text("1",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min, // Wrap content
                          children: [
                            Text("Shop",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                )),
                            SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color:
                                    Color(0xFFffffff), // Dot background color
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text("2",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min, // Wrap content
                          children: [
                            Text("Shop",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                )),
                            SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color:
                                    Color(0xFFffffff), // Dot background color
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text("3",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min, // Wrap content
                          children: [
                            Text("Shop",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                )),
                            SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color:
                                    Color(0xFFffffff), // Dot background color
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text("4",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min, // Wrap content
                          children: [
                            Text("Shop",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                )),
                            SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color:
                                    Color(0xFFffffff), // Dot background color
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text("5",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 16),
                Text("Username",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 350,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                    color: Colors.white), // Style for the text
                                children: [
                                  TextSpan(
                                    text: isExpanded
                                        ? widget.text // Full text when expanded
                                        : widget.text.length > textLimit
                                            ? widget.text
                                                    .substring(0, textLimit) +
                                                "..." // Truncated text
                                            : widget
                                                .text, // Full text if it fits within the limit
                                  ),
                                  if (widget.text.length > textLimit)
                                    TextSpan(
                                      text: isExpanded
                                          ? " see less"
                                          : " see more",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                    ),
                                ],
                              ),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 20), // Space between description and music/effect
                // Music and Effect UI
                Row(
                  children: [
                    // Music
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/music.png"),
                          SizedBox(width: 4),
                          Text(
                            "Falz • How Many (fe...",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8), // Space between Music and Effect
                    // Effect
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/magicpen.png"),
                          SizedBox(width: 4),
                          Text(
                            "Effect Name",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
