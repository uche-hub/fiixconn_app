import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final List<String> externalVideos = [
    'https://videos.pexels.com/video-files/4057322/4057322-sd_506_960_25fps.mp4',
    'https://videos.pexels.com/video-files/4058084/4058084-sd_506_960_25fps.mp4',
    'https://videos.pexels.com/video-files/3959544/3959544-sd_506_960_25fps.mp4',
    'https://videos.pexels.com/video-files/4038571/4038571-sd_506_960_25fps.mp4',
    'https://videos.pexels.com/video-files/5595352/5595352-sd_360_640_24fps.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.menu),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LIVE", style: TextStyle(color: Colors.grey, fontSize: 16)),
            SizedBox(width: 16),
            Text("Following", style: TextStyle(color: Colors.grey, fontSize: 16)),
            SizedBox(width: 16),
            Column(
              children: [
                Text("For You",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
          return VideoCard(videoUrl: externalVideos[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Mini Apps"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Messages"),
          BottomNavigationBarItem(
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue,
                  border: Border.all(color: Colors.blue[900]!, width: 2),
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
              label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final String videoUrl;

  VideoCard({required this.videoUrl});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _showHeart = false; // Flag for showing the heart animation
  int _likeCount = 1200;   // Initial like count
  bool _showDropdown = false; // Dropdown visibility toggle

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl) // Changed to `network`
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
                CircleAvatar(backgroundColor: Colors.white, radius: 20),
                SizedBox(height: 8),
                Icon(Icons.favorite, color: Colors.red),
                Text("$_likeCount", style: TextStyle(color: Colors.white)), // Updated like count
                SizedBox(height: 8),
                Icon(Icons.chat, color: Colors.white),
                Text("17", style: TextStyle(color: Colors.white)),
                SizedBox(height: 8),
                Icon(Icons.bookmark, color: Colors.white),
                Text("12", style: TextStyle(color: Colors.white)),
                SizedBox(height: 8),
                Icon(Icons.share, color: Colors.white),
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
                  child: Row(
                    children: [
                      Icon(Icons.shop, color: Colors.white),
                      SizedBox(width: 4),
                      Text("Shop", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 4),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Color(0xFF1A1A1A), // Dot background color
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text("4", style: TextStyle(color: Colors.white)),
                    ],
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
                        Text("Shop 1", style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Shop 2", style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Shop 3", style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Shop 4", style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Shop 5", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                SizedBox(height: 8),
                Text("Username", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("This happens to be a great match...",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
